-- BE SURE "tr" and "det" point to corresponding tables

-- PER-OBJECT comparison table
-- create table CMPO_xx10 as -- create index CMPO_xx10_in on CMPO_xx10 (fid,booru) -- drop table CMPO_xx10
select nvl(a.booru,b.booru) booru, nvl(a.fid,b.fid) fid,
       a.obj, cast(objp.nn(substr(a.batch_id,1,2)||a.obj) as varchar2(30)) ann, a.oid, a.x, a.y, a.w, a.h, a.prob, a.suppr, a.sid,
       b.obj bobj, cast(objp.nn(substr(b.batch_id,1,2)||b.obj) as varchar2(30)) bnn, b.oid boid, b.x b_x, b.y b_y, b.w b_w, b.h b_h,
       iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h) iou,
       iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h,1) iou1,
       iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h,2) iou2,
       substr(nvl(a.oid,b.oid),1,1) lvl, nvl(a.exif_ar,b.exif_ar) exif_ar,
       cast(OBJQ(a.obj,a.prob,a.x,a.y,a.w,a.h,a.exif_ar) as varchar2(30)) q,
       cast(OBJQ(b.obj,1.0,b.x,b.y,b.w,b.h,b.exif_ar) as varchar2(30)) q_b
       , cast(null as varchar2(30)) gone
       , nvl(a.fname,b.iname) fname, lname , nvl(iname,a.fname) iname, substr(nvl(b.batch_id,a.batch_id),1,2) batch_id       
from det a
full join tr b on a.booru=b.booru and a.fid=b.fid and a.sid=b.oid
order by 2, 1

create or replace synonym cmpo for cmpo_xx10
-- excessive train set
delete from cmpo where (booru,fid) not in ( select distinct booru, fid from det ) -- no originals

-- delete weak new (presumably false) detections
-- select round(prob,2) p2 , count(*) cnt from cmpo where suppr is null group by round(prob,2) order by 1 nulls first
delete from cmpo where suppr is null and prob<0.72
-- xx_10 empty 2572 deleted 4611 @ 0.72

-- ext stat
select decode(booru,'tbib.org','FURRY','e621.net','FURRY','ANIME') boo,
       case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end ar,
       objp.ll('XX'||obj)||lpad(obj,2,'0')||'-'||ann ann, objp.ll('XX'||bobj)||lpad(bobj,2,'0')||'-'||bnn bnn,
       round(avg(prob),3) aprob,
       count(*) c
from cmpo
where nvl(suppr,-1)<0 
group by decode(booru,'tbib.org','FURRY','e621.net','FURRY','ANIME'), 
         case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end,
         objp.ll('XX'||obj)||lpad(obj,2,'0')||'-'||ann, objp.ll('XX'||bobj)||lpad(bobj,2,'0')||'-'||bnn --, nvl(substr(q,1,1),'B')
order by 1, 2, 3 -- 3, 4, 2



-- image COMPOSITION and DETECTION COMPLETENESS
-- create table cmpi_xx10 as -- create unique index cmpi_xx10_ui on cmpi_xx10 (fid,booru) -- drop table cmpi_xx10
with o as (select booru, fid, count(*) objs from tr group by booru, fid),
     y as (select max(nvl(iname,'A')) iname, count(*) cnt, sum(decode(q,'G',1,0)) ag, sum(decode(q,'G',0,1)) ab,
                  sum( nvl2(bobj,nvl(iou,0)*nvl(prob,0),prob) * case when nvl(ann,bnn)=nvl(bnn,ann) then 1.0 else 0.8 end) det,
                  max(nvl(lname,'A')) lname, booru, fid, max(nvl(fname,'A')) fname,
                  listagg(distinct objp.ll(batch_id||nvl(bobj,obj))||lpad(nvl(bobj,obj),2,'0')||'-'||objp.nn(batch_id||nvl(bobj,obj)),'; ') 
                    within group (order by decode(objp.ll(batch_id||nvl(bobj,obj)),'H',1,'B',2,3),nvl(bobj,obj)) oo
             from cmpo -- where nvl(suppr,-1)<0
         group by booru, fid)
select y.booru, y.fid, cnt, objs, 
       round(det/greatest(cnt,objs),3) pct,
       oo, round(det,3) det, ag, ab, fname, lname
from o
join y on y.booru=o.booru and y.fid=o.fid
order by det/greatest(cnt,objs) -- desc

create or replace synonym cmpi for cmpi_xx10


-- quality stat (reason to delete "weak tail" for training with NANO model)
-- XX10M : 0.5 == 572 , 0.56 == 1848 , 0.61 == 3715 of 119k
select decode(booru,'tbib.org','FURRY','e621.net','FURRY','ANIME') boo, floor(100*pct) pct, count(*) cnt
from cmpi
group by decode(booru,'tbib.org','FURRY','e621.net','FURRY','ANIME'), floor(100*pct) order by 2,1
-- obj losses after possible cleanup
select obj, count(*) c from det o join cmpi y on y.booru=o.booru and y.fid=o.fid and y.pct<0.4 group by obj order by 1
