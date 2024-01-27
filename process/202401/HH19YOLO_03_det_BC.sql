-- create unique index DET_BC11_UI on DET_BC11 (FID, BOORU, OID, BATCH_ID) -- drop index DET_BC11_UI
-- ************************************************    LOADING *****************************************************************
insert /*+ignore_row_on_dupkey_index (det_bc11, det_bc11_ui ) */ into det_bc11 (batch_id, fname, booru, fid, obj, x, y, w, h, prob, oid )
select 'XX03' batch_id, fname,
       cast(fne(fname,'BOORU') as varchar2(30)) booru,
       to_number(fne(fname,'FID')) fid,
       substr(etc,1,instr(etc,' ',1,1)-1) obj,
       substr(etc,instr(etc,' ',1,1)+1,instr(etc,' ',1,2)-instr(etc,' ',1,1)-1) x,
       substr(etc,instr(etc,' ',1,2)+1,instr(etc,' ',1,3)-instr(etc,' ',1,2)-1) y,
       substr(etc,instr(etc,' ',1,3)+1,instr(etc,' ',1,4)-instr(etc,' ',1,3)-1) w,
       substr(etc,instr(etc,' ',1,4)+1,instr(etc,' ',1,5)-instr(etc,' ',1,4)-1) h,
       substr(etc,instr(etc,' ',1,5)+1) prob,
       objp.oi('XX'||substr(etc,1,instr(etc,' ',1,1)-1),substr(etc,3)) oid       
from ( select substr(fline,instr(fline,'\',-1,1)+1,instr(fline,chr(09),1,1)-instr(fline,'\',-1,1)-1) fname, 
              replace(substr(fline,instr(fline,chr(09),1,1)+1),chr(13),'') etc
--         from ext EXTERNAL MODIFY ( LOCATION ('yolodet_BCB_sm03.tsv') ) ) e -- 3.944.026 >> 3.971.992 + 4.008.866
--         from ext EXTERNAL MODIFY ( LOCATION ('yolodet_BCI_sm03.tsv') ) ) e -- 903.601 >> 910.342 + 920.238
--         from ext EXTERNAL MODIFY ( LOCATION ('yolodet_BCO_sm03.tsv') ) ) e -- 1.900.935 >> 1.923.085 + 1.959.529
--         from ext EXTERNAL MODIFY ( LOCATION ('yolodet_BCN_sm03.tsv') ) ) e -- 2.339.894 (vs 2.339.895) >> 2.355.054 (of 2.355.055) + 3.375.630
         from ext EXTERNAL MODIFY ( LOCATION ('yolodet_BCT_sm03.tsv') ) ) e -- 5.812.997 >> 5.859.966 + 5.924.166
where fne(fname,'FID') is not null

-- DETECTIONS set up for procedures
create or replace synonym detbc for det_bc11

-- patch EXIF info and full actual file names (may be used as filter for later processing)
update detbc y set (exif_iw,exif_ih,exif_ar,fname)=(select min(iw), min(ih), max(round(iw/ih,4)), max(fline) from booru.bc_v where lower(bc_v.booru)=lower(y.booru) and bc_v.fid=y.fid) where exif_ar is null 
select booru, count(*) c, count(distinct fid) cf from detbc where exif_ar is null group by booru -- tbib.org	2
delete from detbc where exif_ar is null -- IRREVERSIBLE notfound drop
-- select * from detbc where exif_ar is null -- select * from booru.bc_v where fid=5294953

-- internal NMS, must be minimal within single model
create or replace synonym det for det_bc11
begin nmsdet('B:\BCB%',1); end; 
begin nmsdet('B:\BCI%',1); end; -- NMSDET B:\BCI%-0 CLEANUP 260 9I=14352 8I=328
begin nmsdet('B:\BCO%',1); end; -- NMSDET B:\BCO%-0 CLEANUP 623 9I=8353 8I=603
begin nmsdet('B:\BCN%',1); end; -- NMSDET B:\BCN%-0 CLEANUP 977 9I=14299 8I=808
begin nmsdet('B:\BCT%',1); end; -- NMSDET B:\BCT%-0 CLEANUP 2412 9I=28968 8I=2063
-- begin nmsdet('B:\BCB%safeb%234406%',1/*crossmodel*/); end;  -- !! NO PP at that moment !!
-- XX11 + SM03 : BCB 9I=2723590 8I=702646 7C=287940 6C=70751
--               BCI 9I=610848  8I=154272 7C=59413  6C=16210
--               BCO 9I=1187915 8I=404721 7C=183087 6C=44162
--               BCN 9I=1619156 8I=417106 7C=172128 6C=41974
--               BCT 9I=3936988 8I=1089826 7C=449290 6C=107803

-- select * from detbc where suppr is not null and fname like 'B:\BCT%' order by prob desc
delete from detbc where suppr is not null and batch_id='XX03' and fname like 'B:\BCT%' -- IRREVERSIBLE internal duplicates drop
-- delete from detbc where prob<0.5 -- OPTIONAL, detect run over 0.4

-- torso join (EXIF fields must be not empty !)
begin detj('B:\BCB%',0); end;
-- XX11                    UP 11900300 >> 4985106 DOWN 6687304 >> 3273570 FERAL 91545 >> 37496 WING 73911 >> 31293 @ 902 sec
-- B:\BCB% CLEANUP 3795052 UP 3167815 >> 1389602 DOWN 1839529 >> 940673 FERAL 24183 >> 9614 WING 19088 >> 7891
-- B:\BCI% CLEANUP 758771  UP 543433 >> 262982   DOWN 402954 >> 217083  FERAL 52263 >> 20600 WING 43556 >> 17021
-- B:\BCO% CLEANUP 1679186 UP 2273435 >> 686193  DOWN 1191918 >> 411443 FERAL 12695 >> 3680  WING 9201 >> 3258
-- B:\BCN% CLEANUP 2152442 UP 1725954 >> 835999  DOWN 1038464 >> 558898 FERAL 8309 >> 3523  WING 8716 >> 3684
-- B:\BCT% CLEANUP 5320784 UP 5556249 >> 2068171 DOWN 3148687 >> 1404997 FERAL 20761 >> 7951 WING 20693 >> 7949

-- begin detj('B:\BCB%11695973066964150000%',1); end; -- debug mode

-- SCENE STRUCTURE @ 1060 sec !
-- create table str_bc11s as -- create unique index str_bc11s_ui on str_bc11s (fid, booru) -- drop table str_bc11s
select d.booru, d.fid,
       sum(decode(lvl,'H',1,0)) h, sum(decode(lvl||q,'HG',1,0)) hg, sum(decode(lvl||q||j,'HGJ',1,0)) hgj,
       sum(decode(lvl,'B',1,0)) b, sum(decode(lvl||q,'BG',1,0)) bg, sum(decode(lvl||q||j,'BGJ',1,0)) bgj,
       sum(decode(lvl,'S',1,0)) s, sum(decode(lvl||q,'SG',1,0)) sg, sum(decode(lvl||q||j,'SGJ',1,0)) sgj,
       listagg(distinct decode(lvl,'H',nn||'-'||pp||';','')) within group (order by pp, obj) hh,
       listagg(distinct decode(lvl,'B',nn||'-'||pp||';','')) within group (order by pp, obj) bb,
       listagg(distinct decode(lvl,'S',nn||'-'||pp||';','')) within group (order by pp, obj) ss,
       round(avg(decode(lvl,'H',prob,null)),3) havg,
       round(avg(decode(lvl,'B',prob,null)),3) bavg,
       round(avg(decode(lvl,'S',prob,null)),3) savg, b.fline, round(b.iw/b.ih,3) ar
from (
select booru, fid, obj, prob,
       substr(oid,1,1) lvl,
       objp.nn(substr(batch_id,1,2)||obj) nn,
       case when prob>0.86 then 'A' when prob>0.72 then 'B' else 'C' end pp, 
       cast(OBJQ(obj,prob,x,y,w,h,exif_ar) as varchar2(30)) q,
       nvl2(oup||odn,'J','U') j
from detbc
where batch_id like 'XX%' and suppr is null -- and fname like 'B:\BCB%'
-- ) d join booru.bc_v b on b.booru=d.booru and b.fid=d.fid and bc='BCB'
) d left join booru.bc_v b on b.booru=d.booru and b.fid=d.fid and bc not in ('BCX','BCXA')
group by d.booru, d.fid, b.fline, round(b.iw/b.ih,3)
-- select * from str_bc11 where (booru,fid) in ( select booru, fid from str_bc11 group by booru, fid having count(*)>1 ) for update 

-- ******************************************************************       USAGE        ****************************************************************
-- be sure !
create or replace synonym detbc for det_bc11
create or replace synonym strbc for str_bc11s
-- browse
select * from detbc where fid=234406 order by booru, fid, obj, x*y

-- track a single case
select detbc.*, v.fline from detbc join booru.bc_v v on v.booru=detbc.booru and v.fid=detbc.fid
where detbc.fid=5950279 -- and batch_id like 'XX%' -- booru='pixiv.sfs'
  
-- virtually joined
select d.*, 'xcopy "'||v.fline||'" A:\BC\' xxcc from det_j3 d join booru.bc_v v on v.booru=d.booru and v.fid=d.fid
where d.fid=1124

-- YOLOJ drawing : export to clip as CSV, insert IDX into header
select -- #"IDX";"FNAME";"HOBJ";"PROB";"X";"Y";"W";"H";"OBJ";"OPROB";"OX";"OY";"OW";"OH";"ONAME";"OID";"BOID"
       t.fline fname, t.fname hobj, prob, x, y, w, h, bname obj, oprob, ox, oy, ow, oh,
       'A:\BC\'||t.booru||'-'||t.fid||'.jpg' oname, -- output file name
       substr(oid,1,4) oid, substr(boid,1,4) boid
from detbc_j2_v t
where t.fid between 1104280 and 1104840 -- =995153
order by t.fline, decode(substr(oid,1,1),'H',1,'B',2,3)

-- the same using STR
select -- #"IDX";"FNAME";"HOBJ";"PROB";"X";"Y";"W";"H";"OBJ";"OPROB";"OX";"OY";"OW";"OH";"ONAME";"OID";"BOID"
       str.fline fname, case when fbat='XX03' then upper(t.fname) else t.fname end hobj, prob, t.x, y, w, t.h, 
                        case when bbat='XX03' then upper(bname) else bname end obj,      oprob, ox, oy, ow, oh,
--       str.fline fname, t.fname hobj, t.prob, t.x, t.y, t.w, t.h, t.bname obj, t.oprob, t.ox, t.oy, t.ow, t.oh,
       'A:\BC\'||t.booru||'-'||t.fid||'.jpg' oname, -- output file name
       substr(t.oid,1,4) oid, substr(t.boid,1,4) boid
from strbc str
join detbc_j2_v t on str.booru=t.booru and str.fid=t.fid
where str.booru='e621.net' and str.h=4 and hh not like '%-C%' and hh not like '%-B%'
  and lower(bname)!='suppr' 
  and str.fid between 3470000 and 3480000
order by str.fline, decode(substr(oid,1,1),'H',1,'B',2,3), prob


-- compare XX10 with XX09@booru
select * 
from strbc str join booru.yolobj9 j on j.booru=str.booru and j.fid=str.fid
where str.fid=1124


-- define NOT_IN_TRAIN subset of interest using STRUCTURE 
with eee as (

   select yj.*, 
          'echo F| xcopy "'||fline||'" A:\BC\HHORSE'||
             floor(row_number() over (order by least(nvl(havg,1),nvl(bavg,1),nvl(savg,1)) desc)/1000)||
             '\'||yj.booru||'-'||yj.fid||'.jpg' xxcc
     from str_bc11 yj
left join det_XX11 y on y.booru=yj.booru and y.fid=yj.fid
    where y.prob is null                             -- not in train
      and yj.booru not in ('tag','exnt','pixiv.sfs') -- banned SRCs
      and greatest(yj.h,yj.b,yj.s)<4                 -- not a crowd
--      and (hh like '%hhorse-A%' or hh like '%h horse-B%')
      and hh like '%hhorse-A%' and bb||ss is not null
--      and ss like '%split-A%' and hh not in ('head-A;','head-B;')
      and hh||bb||ss not like '%-C%'
      and nvl(ss,'-') not like '%jack%' and nvl(ss,'-') not like '%vsp%' -- prevoius steps      
   order by least(nvl(havg,1),nvl(bavg,1),nvl(savg,1)) desc fetch first 3900 rows only
   -- offset 800 rows fetch next 1200 rows only
   
 ) -- DRAW it
select -- #"IDX";"FNAME";"HOBJ";"PROB";"X";"Y";"W";"H";"OBJ";"OPROB";"OX";"OY";"OW";"OH";"ONAME";"OID";"BOID"
       eee.fline fname, t.fname hobj, t.prob, t.x, t.y, t.w, t.h, t.bname obj, t.oprob, t.ox, t.oy, t.ow, t.oh,
       'JACK\'||t.booru||'-'||t.fid||'.jpg' oname, -- output file name
       substr(t.oid,1,4) oid, substr(t.boid,1,4) boid
from eee
join detbc_j2_v t on eee.booru=t.booru and eee.fid=t.fid
order by eee.fline, decode(substr(oid,1,1),'H',1,'B',2,3)


-- LYING and UPSIDE-DOWN detection using TILT
with ttt as (

   select /*+materialize */ yj.*, 
          'echo F| xcopy "'||fline||'" A:\BC\TILF'||
             floor(row_number() over (order by least(nvl(havg,1),nvl(bavg,1),nvl(savg,1)) desc)/400)||
             '\'||yj.booru||'-'||yj.fid||'.jpg' xxcc
     from ( select distinct t.booru, t.fid, havg, bavg, savg, fline
              from detbc_j2_v t
              join str_bc11 s on s.booru=t.booru and s.fid=t.fid and s.h<=4
             where t.nn in (1,2,3) and tilty<-0.3 
               and s.booru in ('e621.net','tbib.org')
               and bname in ('hip','belly','butt') -- not in ('wing','jackx','jacko')
               -- and s.fline like 'B:\BCB\%3x2%'
               -- and (s.fline like 'B:\BCN\%1x1%' or s.fline like 'B:\BCN\%3x4%')
               -- and t.fid between 1000000 and 1000999 
               ) yj
left join det_XX11 y on y.booru=yj.booru and y.fid=yj.fid
    where y.prob is null                             -- not in train
      and yj.booru not in ('tag','exnt','pixiv.sfs') -- banned SRCs
   order by least(nvl(havg,1),nvl(bavg,1),nvl(savg,1)) desc 
   fetch first 4400 rows only
   offset 800 rows fetch next 200 rows only

)
-- select s.*, j.*
select -- #"IDX";"FNAME";"HOBJ";"PROB";"X";"Y";"W";"H";"OBJ";"OPROB";"OX";"OY";"OW";"OH";"ONAME";"OID";"BOID"
       s.fline fname, t.fname hobj, t.prob, t.x, t.y, t.w, t.h, t.bname obj, t.oprob, t.ox, t.oy, t.ow, t.oh,
       'TILT\'||t.booru||'-'||t.fid||'.jpg' oname, -- output file name
       substr(t.oid,1,4) oid, substr(t.boid,1,4) boid
       , tilty
from detbc_j2_v t
join str_bc11 s on s.booru=t.booru and s.fid=t.fid
join ttt on ttt.booru=t.booru and ttt.fid=t.fid -- as filter
where 1=1 
 -- t.nn in (1,2) -- and tilty<-0.2 -- and obj2='hip'
--  and t.fid between 6321189 and 6321189
order by s.fline, decode(substr(oid,1,1),'H',1,'B',2,3)





-- STRUCTURE REDIR
   select booru, least(h,3)||least(hgj,3)||'#'||least(bgj,3)||'#'||
          nvl(replace(replace(substr(hh,1,greatest(instr(hh,';',1,2),instr(hh,';',1,1))-1),'-',''),';','_'),'noh')||
           '+'||nvl(substr(bb,1,instr(bb,'-',1,1)-1),'nob') sttr,
          substr(fline,1,6) fl,
          count(*) c
     from str_bc11 yj
    where yj.booru in ('tbib.org','e621.net') -- SRCs
   group by booru, least(h,3)||least(hgj,3)||'#'||least(bgj,3)||'#'||
          nvl(replace(replace(substr(hh,1,greatest(instr(hh,';',1,2),instr(hh,';',1,1))-1),'-',''),';','_'),'noh')||
            '+'||nvl(substr(bb,1,instr(bb,'-',1,1)-1),'nob'),
          substr(fline,1,6)
order by 4 desc


-- BCB with and without 03SM comparison
select b.booru, b.fid, s.h||case when s.h!=b.h then '/'||b.h end h, s.hg||case when s.hg!=b.hg then '/'||b.hg end hg,
                       s.b||case when s.b!=b.b then '/'||b.b end b, s.bg||case when s.bg!=b.bg then '/'||b.bg end bg,
                       s.s||case when s.s!=b.s then '/'||b.s end s, s.sg||case when s.sg!=b.sg then '/'||b.sg end sg,
                       s.hh||case when s.hh!=b.hh then ' / '||b.hh end hh,
                       s.bb||case when s.bb!=b.bb then ' / '||b.bb end bb,
                       s.ss||case when s.ss!=b.ss then ' / '||b.ss end ss,
                       s.havg||case when s.havg!=b.havg then ' / '||b.havg end havg,
                       s.bavg||case when s.bavg!=b.bavg then ' / '||b.bavg end bavg,
                       s.savg||case when s.savg!=b.savg then ' / '||b.savg end savg
from str_bc11 b join str_bc11s s on s.booru=b.booru and s.fid=b.fid
where b.booru='safebooru.org'




select iou(b.x,b.y,b.w,b.h,s.x,s.y,s.w,s.h) iou,
iou(b.x,b.y,b.w,b.h,s.x,s.y,s.w,s.h,1) iou1,
iou(b.x,b.y,b.w,b.h,s.x,s.y,s.w,s.h,2) iou2,
b.*, s.*
from detbc b 
join detbc s on s.booru=b.booru and s.fid=b.fid and substr(s.oid,1,1)=substr(b.oid,1,1) and s.oid!=b.oid -- and b.batch_id='XX11' and s.batch_id='XX03'
where -- b.booru='safebooru.org' and 
b.fid=3477946 -- order by booru, fid, obj, x*y

select * from detbc where fid=3398982 order by booru, fid, obj, x*y
