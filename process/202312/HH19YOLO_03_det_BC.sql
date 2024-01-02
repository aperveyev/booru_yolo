
-- ************************************************    LOADING *****************************************************************
insert /*+ignore_row_on_dupkey_index (det_bc10xx, det_bc10xx_ui ) */ into det_bc10xx (batch_id, fname, booru, fid, obj, x, y, w, h, prob, oid )
select 'XX10' batch_id, fname,
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
--         from ext EXTERNAL MODIFY ( LOCATION ('yolodet_BCB_xx10.tsv') ) ) e -- 3.944.026
--         from ext EXTERNAL MODIFY ( LOCATION ('yolodet_BCI_xx10.tsv') ) ) e -- 903.601
--         from ext EXTERNAL MODIFY ( LOCATION ('yolodet_BCN_xx10.tsv') ) ) e -- 2.339.894 vs 2.339.895
--         from ext EXTERNAL MODIFY ( LOCATION ('yolodet_BCO_xx10.tsv') ) ) e -- 1.900.935
--         from ext EXTERNAL MODIFY ( LOCATION ('yolodet_BCT_xx10.tsv') ) ) e -- 5.812.997
--         from ext EXTERNAL MODIFY ( LOCATION ('yolodet_BC_pp09.tsv') ) ) e -- 382.909 vs 382.912 -- PP
where fne(fname,'FID') is not null

-- DETECTIONS set up for procedures
create or replace synonym detbc for det_bc10

-- patch EXIF info
update detbc y set (exif_iw,exif_ih,exif_ar)=(select min(iw), min(ih), max(round(iw/ih,4)) from booru.bc_v where lower(bc_v.booru)=lower(y.booru) and bc_v.fid=y.fid) where exif_ar is null
select booru, count(*) c from detbc where exif_ar is null group by booru -- tbib.org	2

-- internal NMS, must be minimal within single model
begin nmsdet('%'); end; 
-- BCB_xx10 1I=34494 2I=2915 @ 91 sec ; BCI 1I=18691 2I=718 ; 1I=65842 2I=7092

-- select * from detbc where suppr is not null order by prob desc
delete from detbc where suppr is not null -- IRREVERSIBLE internal duplicates drop
-- delete from detbc where prob<0.5 -- OPTIONAL, detect run over 0.4

-- PP inside XX marked in OXX
begin nmsPX('%') ; end; -- 09PP vs 10XX : I=43200

-- torso join (EXIF fields must be not empty !)
begin detj('%',0); end;
-- BCB : UP 2812493 >> 1318633 DOWN 1607505 >> 872973  FERAL 15993 >> 7169  WING 12208 >> 5607 @ 219 sec
-- BCI : UP 477244  >> 240519  DOWN 351957 >> 197895   FERAL 44160 >> 18147 WING 34766 >> 14418 @ 51 sec
-- ETC : UP 8432018 >> 3394684 DOWN 4634941 >> 2188394 FERAL 30194 >> 9608  WING 22328 >> 8894 @ 602 sec

-- begin detj('%zero%192478%',1); end; -- debug mode

-- SCENE STRUCTURE @ 1300 sec !
-- create table str_bc10 as -- create unique index str_bc10_ui on str_bc10 (fid, booru) -- drop table str_bc10
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
       case when prob>0.85 then 'A' when prob>0.72 then 'B' else 'C' end pp, 
       cast(OBJQ(obj,prob,x,y,w,h,exif_ar) as varchar2(30)) q,
       nvl2(oup||odn,'J','U') j
from detbc
where batch_id like 'XX%' and suppr is null
) d left join booru.bc_v b on b.booru=d.booru and b.fid=d.fid and bc!='BCX'
group by d.booru, d.fid, b.fline, round(b.iw/b.ih,3)
-- select * from str_bc10 where (booru,fid) in ( select booru, fid from str_bc10 group by booru, fid having count(*)>1 ) for update 

create or replace synonym strbc for str_bc10

-- ******************************************************************       USAGE        ****************************************************************

-- track a single case
select detbc.*, v.fline from detbc join booru.bc_v v on v.booru=detbc.booru and v.fid=detbc.fid
where detbc.fid=5950279 -- and batch_id like 'XX%' -- booru='pixiv.sfs'
  
-- virtually joined
select d.*, 'xcopy "'||v.fline||'" A:\BC\' xxcc from det_j3 d join booru.bc_v v on v.booru=d.booru and v.fid=d.fid
where d.fid=1124

select * from strbc where fid=1124

-- YOLOJ drawing : export to clip as CSV, insert IDX into header
select -- #"IDX";"FNAME";"HOBJ";"PROB";"X";"Y";"W";"H";"OBJ";"OPROB";"OX";"OY";"OW";"OH";"ONAME";"OID";"BOID"
       b.fline fname, t.fname hobj, prob, x, y, w, h, bname obj, oprob, ox, oy, ow, oh,
       'A:\BC\'||t.booru||'-'||t.fid||'.jpg' oname, -- output file name
       substr(oid,1,4) oid, substr(boid,1,4) boid
from detbc_j2_v t
join booru.bc_v b on b.booru=t.booru and b.fid=t.fid
where b.fid between 1124 and 1124 -- =995153
order by b.fline, decode(substr(oid,1,1),'H',1,'B',2,3)

select -- #"IDX";"FNAME";"HOBJ";"PROB";"X";"Y";"W";"H";"OBJ";"OPROB";"OX";"OY";"OW";"OH";"ONAME";"OID";"BOID"
       fline fname, t.fname hobj, t.prob, t.x, t.y, t.w, t.h, t.bname obj, t.oprob, t.ox, t.oy, t.ow, t.oh,
       'A:\BC\'||t.booru||'-'||t.fid||'.jpg' oname, -- output file name
       substr(t.oid,1,4) oid, substr(t.boid,1,4) boid
from strbc str
join detbc_j2_v t on str.booru=t.booru and str.fid=t.fid
where str.booru='e621.net' and str.h=5 and hh not like '%-C%' and hh not like '%-B%'
-- where str.fid=1124
order by fline, decode(substr(oid,1,1),'H',1,'B',2,3)


-- compare with XX09 @ booru
select * 
from strbc str join booru.yolobj9 j on j.booru=str.booru and j.fid=str.fid
where str.fid=1124
