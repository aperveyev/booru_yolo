-- QUALITY STAT
with qtr as (
select d.obj, 
       case when s.booru in ('tbib.org','e621.net') then 'F' else 'A' end tp,
       case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end ar,  
       case when s.h-hg=0 and s.b-bg=0 and s.s-sg=0 and hh||bb||ss not like '%-C%' and hh||bb||ss not like '%-B%' then 'AA'
            when hh||bb||ss not like '%-C%' then 'BB' else 'CC' end qq,
       count(*) c 
from str_xx10 s
join det_xx10 d on d.booru=s.booru and d.fid=s.fid and d.batch_id like 'XX%'
group by d.obj,
         case when s.booru in ('tbib.org','e621.net') then 'F' else 'A' end,
         case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end,
         case when s.h-hg=0 and s.b-bg=0 and s.s-sg=0 and hh||bb||ss not like '%-C%' and hh||bb||ss not like '%-B%' then 'AA'
              when hh||bb||ss not like '%-C%' then 'BB' else 'CC' end
), qbc as (
select d.obj, 
       case when s.booru in ('tbib.org','e621.net') then 'F' else 'A' end tp,
       case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end ar,  
       case when s.h-hg=0 and s.b-bg=0 and s.s-sg=0 and hh||bb||ss not like '%-C%' and hh||bb||ss not like '%-B%' then 'AA'
            when hh||bb||ss not like '%-C%' then 'BB' else 'CC' end qq,
       count(*) c 
from str_bc10 s
join det_bc10 d on d.booru=s.booru and d.fid=s.fid and d.batch_id like 'XX%'
where (s.booru,s.fid) not in ( select booru,fid from str_xx10 )
group by d.obj,
         case when s.booru in ('tbib.org','e621.net') then 'F' else 'A' end,
         case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end,
         case when s.h-hg=0 and s.b-bg=0 and s.s-sg=0 and hh||bb||ss not like '%-C%' and hh||bb||ss not like '%-B%' then 'AA'
              when hh||bb||ss not like '%-C%' then 'BB' else 'CC' end
), qx as (
select d.obj, 
       case when s.booru in ('tbib.org','e621.net') then 'F' else 'A' end tp,
       case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end ar,  
       case when s.h-hg=0 and s.b-bg=0 and s.s-sg=0 and hh||bb||ss not like '%-C%' and hh||bb||ss not like '%-B%' then 'AA'
            when hh||bb||ss not like '%-C%' then 'BB' else 'CC' end qq,
       count(*) c 
from str_bcxa s
join det_bcxa d on d.booru=s.booru and d.fid=s.fid and d.batch_id like 'XX%'
where (s.booru,s.fid) not in ( select booru,fid from str_xx10 )
group by d.obj,
         case when s.booru in ('tbib.org','e621.net') then 'F' else 'A' end,
         case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end,
         case when s.h-hg=0 and s.b-bg=0 and s.s-sg=0 and hh||bb||ss not like '%-C%' and hh||bb||ss not like '%-B%' then 'AA'
              when hh||bb||ss not like '%-C%' then 'BB' else 'CC' end
)
select 'TR10' src, objp.ll('XX'||obj)||lpad(obj,2,'0')||'-'||objp.nn('XX'||obj) nn, qtr.*
from qtr
union
select 'BC10' src, objp.ll('XX'||obj)||lpad(obj,2,'0')||'-'||objp.nn('XX'||obj) nn, qbc.*
from qbc
union
select 'QQ10' src, objp.ll('XX'||obj)||lpad(obj,2,'0')||'-'||objp.nn('XX'||obj) nn, qx.*
from qx
order by 1, 2,3



select booru, fid, cnt, objs, pct, oo, det, ag, ab, fname, lname from cmpi_pp09
  
  
-- QUALITY STAT PP
with qtr as (
select d.obj, 
       case when s.booru in ('tbib.org','e621.net') then 'F' else 'A' end tp,
       case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end ar,  
       case when ab=0 then 'AA' else 'BB' end qq,
       count(*) c 
from cmpi_pp09 s
join det_pp09 d on d.booru=s.booru and d.fid=s.fid and d.batch_id like 'PP%'
group by d.obj,
         case when s.booru in ('tbib.org','e621.net') then 'F' else 'A' end,
         case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end,
         case when ab=0 then 'AA' else 'BB' end
), qx as (
select d.obj, 
       case when s.booru in ('tbib.org','e621.net') then 'F' else 'A' end tp,
       case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end ar,  
       case when least(nvl(vavg,0.86),nvl(pavg,0.86),nvl(xavg,0.86))>=0.86 and nvl(vv||pp,'-') not like '%-C%' and nvl(vv||pp,'-') not like '%-B%' then 'AA'
            when least(nvl(vavg,0.72),nvl(pavg,0.72),nvl(xavg,0.72))>=0.72 and nvl(vv||pp,'-') not like '%-C%' then 'BB'
            else 'CC' end qq,
       count(*) c 
-- select *       
from str_bcxa s
join det_bcxa d on d.booru=s.booru and d.fid=s.fid and d.batch_id like 'PP%'
where (s.booru,s.fid) not in ( select booru,fid from cmpi_pp09 )
-- and nvl(vv||pp,'-') not like '%-C%' -- and nvl(vv||pp,'-') not like '%-B%' and obj=8 order by prob desc
group by d.obj,
         case when s.booru in ('tbib.org','e621.net') then 'F' else 'A' end,
         case when exif_ar between 0.8 and 1.2 then 'S' when exif_ar>1 then 'L' else 'V' end,
       case when least(nvl(vavg,0.86),nvl(pavg,0.86),nvl(xavg,0.86))>=0.86 and nvl(vv||pp,'-') not like '%-C%' and nvl(vv||pp,'-') not like '%-B%' then 'AA'
            when least(nvl(vavg,0.72),nvl(pavg,0.72),nvl(xavg,0.72))>=0.72 and nvl(vv||pp,'-') not like '%-C%' then 'BB'
            else 'CC' end
)
select 'TR09' src, objp.ll('PP'||obj)||lpad(obj,2,'0')||'-'||objp.nn('PP'||obj) nn, qtr.*
from qtr
union
select 'QQ09' src, objp.ll('PP'||obj)||lpad(obj,2,'0')||'-'||objp.nn('PP'||obj) nn, qx.*
from qx
order by 1, 2, 3

