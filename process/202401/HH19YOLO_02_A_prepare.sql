----- ************************************************************ RESULTS SET **************************************
create or replace synonym det for det_sm03 -- DETECTIONS

begin nmsdet('%%'); end; -- detections NMS, must be minimal within single model
/* pp_09 1I=80 2I=5 */
/* xx_10 1I=2983 2I=151 */
/* xx11_k 1I=5040 2I=309 */
/* xx11u  1I=3430 2I=139 */
/* sm03   1I=391 2I=20 */
delete from det where suppr is not null -- IRREVERSIBLE internal duplicates 
-- select * from det where suppr is not null order by prob desc
-- delete from yolob where prob<0.5 -- detect run over 0.35 -- +8875

-- object quality rely on real AR so we have to EXIF
merge into det o using ( -- 
  select t.booru, t.fid, max(ar) ar, max(v.fname) fname, max(v.iw) iw, max(v.ih) ih
    from det t
    join exif v on v.booru=t.booru and v.fid=t.fid
   where exif_ar is null
group by t.booru, t.fid ) n on (o.booru=n.booru and o.fid=n.fid)
when matched then update set exif_ar=ar, o.oname=n.fname, o.exif_iw=n.iw, o.exif_ih=n.ih

-- file name
update det y set fname=(select max(fline) from dir b where b.fid=y.fid and b.booru=y.booru and fline like '%.jpg') -- where fname is null

-- CHECK
select * from det where suppr is null and (exif_ar is null or oname is null or fname is null )
-- delete from det where exif_ar is null -- ? obsolete ?

----- ************************************************************ TRAIN SET **************************************
create or replace synonym tr   for tr_sm03   -- TRAINING DATASET
create or replace synonym dir  for dir_sm03
create or replace synonym exif for exif_sm03

-- patch filenames (to it only afred ddaset extension)
create table dir_sm03 as -- drop table dir_sm03
select booru, fid, fline
from dir_bs_ext_v 
where fid is not null

-- create index dir_sm03_i on dir_sm03 (fid,booru) -- 
-- select * from dir_sm03 where (fid,booru) in (select fid, booru from dir_sm03 group by fid, booru having count(*)>2) for update

create table exif_sm03 as -- drop table exif_sm03
select booru, fid, iw, ih, ar, px, filesize, jq, ifmt, fline fname
from exif_ext_v 

-- object quality rely on real AR so we have to EXIF
merge into tr o using ( 
  select t.booru, t.fid, max(ar) ar
    from tr t
    join exif v on v.booru=t.booru and v.fid=t.fid
   where exif_ar is null
group by t.booru, t.fid
) n on (o.booru=n.booru and o.fid=n.fid)
when matched then update set exif_ar=ar

update tr y set iname=(select min(fline) from dir b where b.fid=y.fid and b.booru=y.booru and fline like '%.jpg') where iname is null -- and suppr is not null
update tr y set lname=(select min(fline) from dir b where b.fid=y.fid and b.booru=y.booru and fline like '%.txt') where lname is null -- and suppr is not null

-- CHECK
select * from tr where exif_ar is null or iname is null or lname is null -- for update

-- check IMAGES vs LABELS
select j.fline, 'del '||l.fline del_lbl
from (select * from dir where fline like '%jpg') j
full join (select * from dir where fline like '%txt') l on j.booru=l.booru and j.fid=l.fid
where (j.fline is null or l.fline is null) and nvl(j.fline,'x') not like '%noobj%'
  
-- STAT
select objp.ll(substr(batch_id,1,2)||obj)||lpad(obj,2,'0')||'-'||objp.nn(substr(batch_id,1,2)||obj) nn, 
       case when booru in ('tbib.org','e621.net') then 'F' else 'A' end tp,
       case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end ar,  
       count(distinct fname) cf, count(*) c
from tr
group by objp.ll(substr(batch_id,1,2)||obj)||lpad(obj,2,'0')||'-'||objp.nn(substr(batch_id,1,2)||obj),
         case when booru in ('tbib.org','e621.net') then 'F' else 'A' end,
         case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end
order by 1, 2, 3

-- STAT DET (by obj listagg)
select batch_id, booru, ar, objs, count(*) cnt from (
select listagg(distinct objp.ll(substr(batch_id,1,2)||obj)||lpad(obj,2,'0')||'-'||objp.nn(substr(batch_id,1,2)||obj),',') within group (order by obj) objs, 
       case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end ar, batch_id, booru, fid, count(*) c
from tr
group by batch_id, booru, fid, exif_ar
) /*where objs like '%hcat%'*/ group by batch_id, booru, ar, objs
order by 5 desc

-- NMS over TXTs to exclude internal overlaps
merge into tr o using (
  select booru, fid, oid, max(boid) boid, max(suppr) suppr from (
    select a.booru, a.fid, a.oid, b.oid boid, 10000+100*b.obj+a.obj suppr,
           first_value(a.oid) over (partition by a.booru, a.fid, b.oid order by iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h) desc ) suid
     from tr a -- suppressed
     join tr b on a.booru=b.booru and a.fid=b.fid -- suppressor
                 and a.oid!=b.oid and a.w*a.h<=b.w*b.w
                 and ( iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h)>0.5 and
                       iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h,1)>0.6 and
                       iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h,2)>0.6 )
     where a.suppr is null and b.suppr is null
    ) group by booru, fid, oid
  ) n on (n.fid=o.fid and n.booru=o.booru and o.oid=n.oid)
when matched then update set /*o.obj=-1*n.suppr,*/ o.suppr=n.suppr, o.sid=n.boid
-- REVERT : update tr set suppr=null, sid=null where suppr is not null -- delete from tr where suppr is not null
-- select * from tr where suppr is not null

-- CHECK train overlaps
select 'xcopy '||iname||' Y:\'||decode(substr(batch_id,1,2),'PP','AAP','AAX')||'\LIMG\ ' xc, fid, lpad(mod(fid,10000),4,'0') fi
from tr
where suppr is not null -- internal duplicates
union -- distinct BTW
select 'xcopy '||lname||' Y:\'||decode(substr(batch_id,1,2),'PP','AAP','AAX')||'\LIMG\ ' xc, fid, lpad(mod(fid,10000),4,'0') fi
from tr
where suppr is not null -- internal duplicates
order by 2

-- ***************************************************  DETECTION vs DATASET main processing *********************************************************
-- after train set cleanup delete already excessive detections not to confuse comparison
delete from det where (booru,fid) not in ( select booru, fid from tr )
-- MAIN , be sure your synonyms actual !!!
begin nmscmp('%'); end;
/* PP_09 0.95=28669  0.9=16492  0.8=10141 0.7=1994  0.6=359 */
/* XX_10 0.95=221417 0.9=103306 0.8=55776 0.7=10092 0.6=1593 */
/* XX11k 0.95=271305 0.9=112666 0.8=62442 0.7=13035 0.6=3046 */
/* XX11p 0.95=271347 0.9=112909 0.8=62484 0.7=13009 0.6=2885 */
/* XX11u 0.95=279032 0.9=111198 0.8=59679 0.7=10937 0.6=1988 */
/* sm03 

-- ***************************************************       OTHER PREPARATIONS              *********************************************************

-- RENAME to train
select 'move '||replace(fline,'Y:','E:')||' '||replace(fne(fline,'FPATH'),'Y:','E:')||'\'||
       lpad(mod(fid,10000),4,'0')||'~'||fne(fline,'FNAME') mmvv
from dir
where fline not like '%\labels\%'
order by lpad(mod(fid,10000),4,'0'), booru, fid

-- TRAIN mogrify STAGE 1
select filesize, iw, ih, px, jq, round(filesize/(iw*ih),3) bpp
, 'magick convert "'||fname||'" '||
  case when iw/ih between 0.8 and 1.2 and px>1600*1600 then '-resize 1280x1280^>'
       when                               px>1920*1920 then '-resize 1600x1600^>'
       else to_char(null) end|| 
  ' '||
  case when jq>=98 then '-quality 94' else to_char(null) end||
  ' "'||replace(fname,'\train\','\traic\')||'"' mm
from exif e
-- order by filesize desc
where ( jq between 98 and 100
     or (iw/ih between 0.8 and 1.2 and px>1600*1600) 
     or px>1920*1920 ) 
  and ( (filesize>400000 and jq>85) or filesize>1000000 )

-- recreate EXIF >> TRAIN mogrify STAGE 2
select filesize, iw, ih, px, jq, round(filesize/(iw*ih),3) bpp
, 'magick convert "'||fname||'" '||
  case when iw/ih between 0.8 and 1.2 then '-resize 1024x1024^>'
       else '-resize 1280x1280^>' end|| 
  ' '||
  case when jq>=98 then '-quality 94 ' else ' ' end||
  case when filesize/(iw*ih)>0.6 and jq<98 then '-blur 4 ' else ' ' end||
  ' "'||replace(fname,'\train\','\traic\')||'"' mm
from exif e
where filesize>=1000000 or ((px>2500000 or iw>1920 or ih>1920) and filesize>500000 and jq>85)

-- select * from exif e where ifmt!='JPEG'
