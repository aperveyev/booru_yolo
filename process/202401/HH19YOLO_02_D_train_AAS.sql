create table dir_as03 as -- drop table dir_as03
select booru, fid, fline
from dir_bs_ext_v 
where fid is not null
-- create index dir_as03_i on dir_as03 (fid,booru) -- 
-- select * from dir_as03 where (fid,booru) in (select fid, booru from dir_as03 group by fid, booru having count(*)>2) for update

-- extract SFW subset from AAX
with nn as (
select o.booru, o.fid, 'D'||bd.danb_r||'G'||bg.glb_r||'C'||bc.snk_r||'T'||bt.tbib_r||'Y'||br.yndr_r||'A'||ba.apic_r||'K'||bk.kona_r||'E'||be.e621_r rr
-- select count(*) c -- 51783 >> 50870
from dir_xx11 o
left join booru.booru_2023 br on o.booru='yande.re' and o.fid=br.yndr_id
left join booru.booru_2023 bg on o.booru='gelbooru.com' and o.fid=bg.glb_id
left join booru.booru_2023 ba on o.booru='anime-pictures.net' and o.fid=ba.apic_id
left join booru.booru_2023 bc on o.booru='chan.sankakucomplex.com' and o.fid=bc.snk_id
left join booru.booru_2023 bd on o.booru='danbooru.donmai.us' and o.fid=bd.danb_id
left join booru.booru_2023 bk on o.booru='konachan.com' and o.fid=bk.kona_id
left join booru.booru_2023 be on o.booru='e621.net' and o.fid=be.e621_id
left join booru.booru_2023 bt on o.booru='tbib.org' and o.fid=bt.tbib_id
join cmpi_xx11 ww on ww.booru=o.booru and ww.fid=o.fid
where nvl(oo,'-') not like '%B02%' and nvl(oo,'-') not like '%B04%' and nvl(oo,'-') not like '%S06%' 
  and nvl(oo,'-') not like '%S08%' and nvl(oo,'-') not like '%S10%' and nvl(oo,'-') not like '%S12%'
  and pct>0.6 -- no unsafe classes, reasonable match quality
  and ( o.booru in ('safebooru.org','www.zerochan.net','e-shuushuu.net') 
   or ( bd.danb_r||bg.glb_r||bc.snk_r||bt.tbib_r||br.yndr_r||ba.apic_r||bk.kona_r||be.e621_r not like '%e%'
    and bd.danb_r||bg.glb_r||bc.snk_r||bt.tbib_r||br.yndr_r||ba.apic_r||bk.kona_r||be.e621_r not like '%q%' )
   or bd.danb_r||bg.glb_r||bc.snk_r||bt.tbib_r||br.yndr_r||ba.apic_r||bk.kona_r||be.e621_r is null )
  and o.fline like '%.jpg'
)
select 'magick convert "'||b.fline||'" -resize 640x640^> '||' "'||replace(b.fline,'Y:\AAX\','A:\AAN\')||'"' vvjj,
       'echo F|xcopy "'||replace(replace(b.fline,'.jpg','.txt'),'images','labels')||'" "'
                       ||replace(replace(replace(b.fline,'Y:\AAX\','A:\AAN\'),'.jpg','.txt'),'images','labels')||'"' ccll
from dir_xx11 b
join nn on nn.booru=b.booru and nn.fid=b.fid
left join dir_as03 y on y.booru=b.booru and y.fid=b.fid
where b.fline like '%.jpg'
 and y.fid is null                             -- not in train
-- and (b.booru in ('safebooru.org','www.zerochan.net','e-shuushuu.net') or rr!='DGCTYAKE')
-- BOORU rating not found so MUST recheck MANUALLY (4259)
 and b.booru not in ('safebooru.org','www.zerochan.net','e-shuushuu.net') and rr='DGCTYAKE'     


-- check IMAGES vs LABELS
select j.fline, 'del '||l.fline del_lbl
from (select * from dir_bs_ext_v where fext='jpg') j
full join (select * from dir_bs_ext_v where fext='txt') l on j.booru=l.booru and j.fid=l.fid
where j.fline is null or l.fline is null

---- wrong extension(-s) and path(-s)
select fext, fpath, count(*) cnt
-- select * 
from dir_bs_ext_v -- where fext='JPG'
group by fext, fpath
----
select * from dir_bs_ext_v where (fid,booru) in (select fid, booru from dir_bs_ext_v group by fid, booru having count(*)>2)


-- renaME to train
select 'move '||fline||' '||fpath||'\'||lpad(mod(fi,10000),4,'0')||'~'||fname mv, lpad(mod(fi,10000),4,'0') dd
from ( select fline, fpath, fname, 
              regexp_substr(regexp_substr(substr(fname,5),'[^\]+$'),'[0-9]+',1,1) fi 
         from dir_bs_ext_v )
where fline like '%.jpg' or fline like '%.txt'
order by 2


-- patch AAX filenames according to AAS as safety filter
-- a lot of HREAR with BOOB become unsafe ...
select * from (
select j.fline jline, l.fline lline,
       case when l.fline is not null and j.fline like '%L.%' then 'move '||j.fline||' '||replace(j.fline,'_L.','.')
            when l.fline is not null and j.fline like '%R.%' then 'move '||j.fline||' '||replace(j.fline,'_R.','.')         
            when l.fline is not null and j.fline like '%X.%' then 'move '||j.fline||' '||replace(j.fline,'_X.','.')         
            when l.fline is not null and j.fline like '%E.%' then 'move '||j.fline||' '||replace(j.fline,'_E.','.')         
            when l.fline is not null and j.fline like '%U.%' then 'move '||j.fline||' '||replace(j.fline,'_U.','.') 
            when l.fline is null and j.fline not like '%L.%' and j.fline not like '%R.%'  
                                 and j.fline not like '%X.%' and j.fline not like '%E.%' 
                                 and j.fline not like '%U.%' then 'move '||j.fline||' '||replace(replace(j.fline,'.txt','_Q.txt'),'.jpg','_Q.jpg')
       end mmvv
from (select * from dir_bs_ext_v where fline like 'Y:\AAX%' ) j
left join (select * from dir_bs_ext_v where fpath is null ) l on j.fext=l.fext and nvl(j.booru,j.booru2)=nvl(l.booru,l.booru2) 
   and to_number(nvl(j.fid,decode(j.fnum1,621,j.fnum2,j.fnum1)))=to_number(nvl(l.fid,decode(l.fnum1,621,l.fnum2,l.fnum1)))
order by decode(j.fnum1,621,j.fnum2,j.fnum1)
) where mmvv is not null




-- compare safe subset objects with main one
select 'echo F|xcopy '||lname||' '||replace(lname,'Y:\AAX\','A:\AAN\') ccll
, a.*
from (
select s.booru, s.fid, x.lname, 
       listagg(s.oid,',') within group (order by s.oid desc) soids,
       listagg(x.oid,',') within group (order by x.oid desc) xoids
from tr_as03 s
join tr_xx11 x on x.booru=s.booru and x.fid=s.fid -- and x.oid=s.oid
group by s.booru, s.fid, x.lname
) a where soids!=xoids

---- extension(-s) and path(-s) and suffixes
select fext, fpath, substr(fname,decode(instr(fname,'_'),0,instr(fname ,'.',-1)+1,instr(fname,'_'))) suff, count(*) cnt
-- select fname, decode(instr(fname,'_'),0,length(fname)-4,instr(fname,'_'))
from dir_bs_ext_v -- where fext='JPG'
group by fext, fpath, substr(fname,decode(instr(fname,'_'),0,instr(fname ,'.',-1)+1,instr(fname,'_')))


------------------------------------------  various cleanups

-- AAS is a SUBSET of AAX not a SUPERSET
select distinct 'del A:\AAS\labels\'||s.fname dll, 'del A:\AAS\images\'||replace(s.fname,'.txt','.jpg') dlj
from tr_as03 s
-- left join tr_xx11 x on x.booru=s.booru and x.fid=s.fid where x.obj is null
join dir_bs_ext_v  x on x.booru=s.booru and x.fid=s.fid

select distinct 'del '||x.fline dlv, x.fid
-- select *
from dir_bs_ext_v x 
join tr_as03 s on x.booru=s.booru and x.fid=s.fid where s.obj in (2,4,6,8,10,12)
order by 2,1

-- delete from tr_as03 where (booru,fid) in ( select booru, fid from tr_as03 where obj in (2,4,6,8,10,12) )
