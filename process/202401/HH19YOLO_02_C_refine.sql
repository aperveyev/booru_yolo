-- (YET) set manually : AAX or AAP , GONE_number, TR_number and location
-- CLEANUP
update cmpo set gone=null where gone is not null
-- delete from cmpo where iname is null or fname is null

-- 2 BAD ( 10w @0.45 : 89 >> 25 ) 
update cmpo set gone='2BAD' where gone is null and (booru,fid) in ( select booru,fid from cmpi where pct between 0.0 and 0.45 )  -- generally BAD
select 'move '||lname||' Y:\AAX\GONE11\2BAD'||substr(lname,instr(lname,'\',-1,2)) mvl,
       'move '||iname||' Y:\AAX\GONE11\2BAD'||substr(iname,instr(iname,'\',-1,2)) mvi,
       'move '||replace(iname,'Y:\AAX\images\train\','N:\AAX\tr11u\')||' Y:\AAX\GONE11\2BAD'||substr(iname,instr(iname,'\',-1,1)) mvd,
       'xcopy '||lname||' Y:\AAX\LIMG\' xcl, -- 'xcopy '||iname||' Y:\AAX\LIMG\' xci,
       'xcopy '||replace(iname,'Y:\AAX\images\train\','N:\AAX\tr11u\')||' Y:\AAX\LIMG\' xcd
from ( select booru, fid, max(nvl(iname,'A')) iname, max(nvl(lname,'A')) lname, max(nvl(fname,'A')) fname
         from cmpo
        where (booru,fid) in ( select booru,fid from cmpo where gone='2BAD' )
     group by booru, fid )

-- 3499     
-- update cmpo set gone='2BAD' where gone is null and (booru,fid) in ( select booru,fid from cmpi where pct<0.5 )  -- generally BAD     

-- 3 CROWD ( 10G 459 >> 31)
update cmpo set gone='3CROWD' where gone is null and (booru,fid) in ( select booru,fid from cmpi where cnt>13 ) -- too many objects
update cmpo set gone='3CROWD' where gone is null and (booru,fid) in ( select booru,fid from cmpi where ab>4 or ab/greatest(ag,1)>3 ) -- too many BADs
select 'move '||lname||' Y:\AAX\GONE11\3CROWD'||substr(lname,instr(lname,'\',-1,2)) mvl,
       'move '||iname||' Y:\AAX\GONE11\3CROWD'||substr(iname,instr(iname,'\',-1,2)) mvi,
       'move '||replace(iname,'Y:\AAX\images\train\','N:\AAX\tr11u\')||' Y:\AAX\GONE11\3CROWD'||substr(iname,instr(iname,'\',-1,1)) mvd
from ( select booru, fid, max(nvl(iname,'A')) iname, max(nvl(lname,'A')) lname, max(nvl(fname,'A')) fname
         from cmpo
        where (booru,fid) in ( select booru,fid from cmpo where gone='3CROWD' )
     group by booru, fid )


-- obj patches
-- object detected not marked >> AUTO-INSERT ? NO ! ( 10g : 823 >> 811 ; 10m : 861 >> 851 ; 10m : 608 >> 596 ) A LOT OF manual REVIEW 
update cmpo set gone='4NEW' where gone is null and (booru,fid) in ( select booru,fid from cmpi where bnn is null and suppr is null and (q='G' or prob>0.73) )
update cmpo set gone='4NEWL' where gone is null and (booru,fid) in ( select booru,fid from cmpi where bnn is null and suppr is null and not (q='G' or prob>0.73) and prob>0.67 )
select 'xcopy '||lname||' Y:\AAX\LIMG\' xcl, 'xcopy '||iname||' Y:\AAX\LIMG\' xci,
       'xcopy '||replace(iname,'Y:\AAX\images\train\','N:\AAX\tr11u\')||' Y:\AAX\LIMG\' xcd
from ( select booru, fid, max(nvl(iname,'A')) iname, max(nvl(lname,'A')) lname, max(nvl(fname,'A')) fname
         from cmpo
        where (booru,fid) in ( select booru,fid from cmpo where gone like '4NEWL' )
     group by booru, fid ) WHERE lname!='A'
-- decompose and append to TXTs
-- select replace(substr(fname,instr(fname,'\',-1,1)+1),'.jpg','.txt')||chr(9)||b.obj||' '||b.x||' '||b.y||' '||b.w||' '||b.h lbl
-- from cmpo b where gone like '4NEW%' and bnn is null and suppr is null


-- misobj ( 10g : 39+1858 >> 2499 ; 10m : 25 + 1256 >> 1244 ; 10w : 34 + 885 >> 881 ) manual review BY miss type
update cmpo set gone='4MISOBJ' where gone is null and (booru,fid) in ( select booru,fid from cmpo where q='G' and substr(oid,1,1)!=substr(boid,1,1) ) -- level miss ALL GOOD
update cmpo set gone='4MISOBJ' where gone is null and (booru,fid) in ( select booru,fid from cmpi where bnn!=ann and q='G' and prob*iou>0.73 ) -- ANY default (maybe 0.9)
select 'xcopy '||lname||' Y:\AAX\LIMG\' xcl, 'xcopy '||iname||' Y:\AAX\LIMG\' xci,
       'xcopy '||replace(iname,'Y:\AAX\images\train\','N:\AAX\tr11u\')||' Y:\AAX\LIMG\' xcf, prob
from ( select booru, fid, max(nvl(iname,'A')) iname, max(nvl(lname,'A')) lname, max(nvl(fname,'A')) fname, min(prob) prob
         from cmpo
        where (booru,fid) in ( select booru,fid from cmpo where gone like '4MISOBJ' 
--           and (substr(sid,1,1)!=substr(oid,1,1)                                  -- FULL level miss
--             or substr(sid,1,1)='B' and substr(oid,1,1)='B' and abs(obj-bobj)>1   -- FULL misbust
--             or substr(sid,1,1)='S' and substr(oid,1,1)='S' and abs(obj-bobj)>1 ) -- FULL missbottom
           and substr(sid,1,1)='H' and substr(oid,1,1)='H' and booru not in ('e621.net','tbib.org')-- TOPMOST mishead of 1248
        )
     group by booru, fid )
order by prob -- desc
fetch first 50 rows only     
offset 400 rows fetch next 100 rows only

-- misplace ( 10g: 1822 >> 1792 ; 10m : 1637 >> 1604 ) manual review FOR TOPMOST ONLY
update cmpo set gone='4MISPL' where gone is null and (booru,fid) in ( select booru,fid from cmpi where suppr<-50000 and bnn=ann )
select 'xcopy '||lname||' Y:\AAX\LIMG\' xcl, 'xcopy '||iname||' Y:\AAX\LIMG\' xci,
       'xcopy '||replace(iname,'Y:\AAX\images\train\','N:\AAX\tr11u\')||' Y:\AAX\LIMG\' xcf, iou
from ( select booru, fid, max(nvl(iname,'A')) iname, max(nvl(lname,'A')) lname, max(nvl(fname,'A')) fname, 
                          min(substr(oid,1,1)) obj, min((1-prob)*(nvl(iou,1)-0.5)) iou
         from cmpo
        where (booru,fid) in ( select booru,fid from cmpo where gone='4MISPL' )
     group by booru, fid ) 
WHERE lname!='A' -- and obj='H'
order by iou 
fetch first 300 rows only     
offset 100 rows fetch next 50 rows only


---------------------------------- advanced cleanups using STRUCTURES and TAGS and OBJS


-- weak STRUCTURE objects to cleanup
update cmpo set gone='6HF' where gone is null and (booru,fid) in 
  ( select booru,fid from STR_xx11 t where booru not in ('e621.net','tbib.org') and HH like '%fox-C%' and h<=3 )
select 'xcopy '||lname||' Y:\AAX\LIMG\' xcl, 'xcopy '||replace(iname,'Y:\AAX\images\train\','N:\AAX\tr11u\')||' Y:\AAX\LIMG\' xcf
from ( select booru, fid, max(nvl(iname,'A')) iname, max(nvl(lname,'A')) lname, max(nvl(fname,'A')) fname
         from cmpo
        where (booru,fid) in ( select booru,fid from cmpo where gone='6HF' )
     group by booru, fid ) 


-- dePP BCX candidates for XX
select 'del '||fline ddll
from (select booru2 booru, decode(fnum1,621,fnum2,fnum1) fid, fline from dir_bs_ext_v where fnum1 is not null )
where (booru,fid) in ( select booru,fid from yolobt9 where batch_id like 'PP%' and obj in (3,6,7) and prob>0.8 )



-- too many wings+hbirds in training set
select 'xcopy '||lname||' Y:\AAX\LIMG\' xcl, 'xcopy '||replace(iname,'Y:\AAX\images\train\','N:\AAX\tr11u\')||' Y:\AAX\LIMG\' xcf, 'xcopy '||fname||' Y:\AAX\LIMG\' xco
from ( select booru, fid, max(nvl(iname,'A')) iname, max(nvl(lname,'A')) lname, max(nvl(fname,'A')) fname
         from cmpo
        where (booru,fid) in ( select booru,fid from yolt1 group by booru, fid having sum(decode(obj,14,1,25,1,0))>=6 )
     group by booru, fid ) WHERE lname!='A'
   


-- BY-TAG extraction for recheck : hat gardevoir isabelle_(animal_crossing)
-- select booru, count(*) c from cmpi group by cube(booru) -- 93872 = ***** www.zerochan.net  1188 e-shuushuu.net  255
update cmpo set gone='6CHKI'||booru 
where gone is null and (booru,fid) in 
    ( select booru,fid from cmpi y join booru.tbib_dt d on d.id=y.fid and d.tag='isabelle' and y.booru='tbib.org' -- tbib.org  29643    
-- union select booru,fid from cmpi y join booru.e621_dt d on d.id=y.fid and d.tag='gardevoir' and y.booru='e621.net'  -- e621.net  7983           
-- union select booru,fid from cmpi y join booru.glb_dt d on d.id=y.fid and d.tag='gardevoir' and y.booru='gelbooru.com' -- gelbooru.com  23311
-- union select booru,fid from cmpi y join booru.snk_dt d on d.id=y.fid and d.tag='gardevoir' and y.booru='chan.sankakucomplex.com'  -- chan.sankakucomplex.com 8468
-- union select booru,fid from cmpi y join booru.sb_dt d on d.id=y.fid and d.tag='gardevoir' and y.booru='safebooru.org'  -- safebooru.org 4338   
-- union select booru,fid from cmpi y join booru.danb_dt d on d.id=y.fid and y.booru='danbooru.donmai.us' and d.tag_cat=0 join booru.danb_tg g on d.tag_id=g.tag_id and g.tag_name='gardevoir' -- dnb 3177
-- union select booru,fid from cmpi y join booru.apic_dt d on d.pid=y.fid and d.tag='gardevoir' and y.booru='anime-pictures.net'  -- anime-pictures.net  2330
-- union select booru,fid from cmpi y join booru.kona_dt d on d.id=y.fid and d.tag='gardevoir' and y.booru='konachan.com'  -- konachan.com  1538
-- union select booru,fid from cmpi y join booru.yndr_dt d on d.id=y.fid and d.tag='gardevoir' and y.booru='yande.re'  -- yande.re  11641
    )  

--select 'xcopy '||lname||' Y:\AAX\LIMG\' xcl, 'xcopy '||replace(iname,'Y:\AAX\images\train\','N:\AAX\tr11u\')||' Y:\AAX\LIMG\' xcf
select 'xcopy '||lname||' Y:\AAX\LIMG\' xcl, 'xcopy '||replace(iname,'Y:\AAX\images\train\','N:\AAX\tr11u\')||' Y:\AAX\LIMG\' xcf, 'xcopy '||fname||' Y:\AAX\LIMG\' xco
from ( select booru, fid, max(nvl(iname,'A')) iname, max(nvl(lname,'A')) lname, max(nvl(fname,'A')) fname
         from cmpo
        where (booru,fid) in ( select booru,fid from cmpo where gone like '6CHKI%' )
     group by booru, fid ) WHERE lname!='A'



---------------------- cross-XX analysis

-- abundant objects (404) maybe not correct >> manual review
with yolwin as ( -- create table yolwin as -- 5 sec -- what model give better result
select nvl(b.booru,a.booru) booru, nvl(b.fid,a.fid) fid,
       iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h) iou, 
       case when b.x is not null and a.x is null then 'S8' when a.x is not null and b.x is null then 'M5' when a.prob>b.prob then 'M'||nvl(a.suppr,b.suppr) else 'S'||nvl(a.suppr,b.suppr) end winner,
       ynmsp.nn(substr(b.batch_id,1,2)||b.obj) obj, b.prob, b.x, b.y, b.w, b.h,-- b.oid,
       ynmsp.nn(substr(a.batch_id,1,2)||a.obj) mobj, a.prob mprob, a.x mx, a.y my, a.w mw, a.h mh--, a.oid aoid
from ( select * from yolobt where batch_id='XXS8' ) b
full outer join ( select * from yolobt where batch_id='XXM5' ) a on a.booru=b.booru and a.fid=b.fid and (a.sid=b.oid or b.sid=a.oid) 
 where nvl(a.suppr,0)>=0 and nvl(b.suppr,0)>=0 -- objects not in dataset inspired by one or both detections (414)
   and YOBJQ(nvl(a.obj,b.obj),nvl(a.prob,b.prob),nvl(a.x,b.x),nvl(a.y,b.y),nvl(a.w,b.w),nvl(a.x,b.h),nvl(a.exif_ar,b.exif_ar))='G'
order by nvl(b.booru,a.booru), nvl(b.fid,a.fid), nvl(a.obj,b.obj) 
)
-- select substr(winner,1,1) WINNER, count(*) c from yolwin group by substr(winner,1,1)
select 'xcopy '||lname||' Y:\AAX\LIMG\' xcl,
       'xcopy '||replace(iname,'\images\train\','\tr10aa\')||' Y:\AAX\LIMG\' xcf
from ( select booru, fid, max(nvl(iname,'A')) iname, max(nvl(lname,'A')) lname, max(nvl(fname,'A')) fname
         from cmpo
        where (booru,fid) in ( select booru,fid from yolwin ) and gone is null
     group by booru, fid ) -- 

