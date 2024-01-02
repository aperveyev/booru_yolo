prompt PL/SQL Developer Export User Objects for user YOLO@HH19
set define off
spool yolo_202312.log

prompt
prompt Creating table CMPI_PP09
prompt ========================
prompt
create table CMPI_PP09
(
  booru VARCHAR2(30),
  fid   NUMBER,
  cnt   NUMBER,
  objs  NUMBER,
  pct   NUMBER,
  oo    VARCHAR2(32767),
  det   NUMBER,
  ag    NUMBER,
  ab    NUMBER,
  fname VARCHAR2(300),
  lname VARCHAR2(160)
)
nologging;

prompt
prompt Creating table CMPI_XX10
prompt ========================
prompt
create table CMPI_XX10
(
  booru VARCHAR2(30),
  fid   NUMBER,
  cnt   NUMBER,
  objs  NUMBER,
  pct   NUMBER,
  oo    VARCHAR2(32767),
  det   NUMBER,
  ag    NUMBER,
  ab    NUMBER,
  fname VARCHAR2(300),
  lname VARCHAR2(160)
)
nologging;
create unique index CMPI_XX10_UI on CMPI_XX10 (FID, BOORU)
  nologging;

prompt
prompt Creating table CMPO_PP09
prompt ========================
prompt
create table CMPO_PP09
(
  booru    VARCHAR2(30),
  fid      NUMBER,
  obj      NUMBER,
  ann      VARCHAR2(30),
  oid      VARCHAR2(8),
  x        NUMBER,
  y        NUMBER,
  w        NUMBER,
  h        NUMBER,
  prob     NUMBER,
  suppr    NUMBER,
  sid      VARCHAR2(8),
  bobj     NUMBER,
  bnn      VARCHAR2(30),
  boid     VARCHAR2(8),
  b_x      NUMBER,
  b_y      NUMBER,
  b_w      NUMBER,
  b_h      NUMBER,
  iou      NUMBER,
  iou1     NUMBER,
  iou2     NUMBER,
  lvl      VARCHAR2(4),
  exif_ar  NUMBER,
  q        VARCHAR2(30),
  q_b      VARCHAR2(30),
  gone     VARCHAR2(30),
  fname    VARCHAR2(300),
  lname    VARCHAR2(160),
  iname    VARCHAR2(300),
  batch_id VARCHAR2(8)
)
nologging;

prompt
prompt Creating table CMPO_XX10
prompt ========================
prompt
create table CMPO_XX10
(
  booru    VARCHAR2(30),
  fid      NUMBER,
  obj      NUMBER,
  ann      VARCHAR2(30),
  oid      VARCHAR2(8),
  x        NUMBER,
  y        NUMBER,
  w        NUMBER,
  h        NUMBER,
  prob     NUMBER,
  suppr    NUMBER,
  sid      VARCHAR2(8),
  bobj     NUMBER,
  bnn      VARCHAR2(30),
  boid     VARCHAR2(8),
  b_x      NUMBER,
  b_y      NUMBER,
  b_w      NUMBER,
  b_h      NUMBER,
  iou      NUMBER,
  iou1     NUMBER,
  iou2     NUMBER,
  lvl      VARCHAR2(4),
  exif_ar  NUMBER,
  q        VARCHAR2(30),
  q_b      VARCHAR2(30),
  gone     VARCHAR2(30),
  fname    VARCHAR2(300),
  lname    VARCHAR2(160),
  iname    VARCHAR2(300),
  batch_id VARCHAR2(8)
)
nologging;
create index CMPO_XX10_IN on CMPO_XX10 (FID, BOORU)
  nologging;

prompt
prompt Creating table DET_BC10
prompt =======================
prompt
create table DET_BC10
(
  batch_id VARCHAR2(8) not null,
  booru    VARCHAR2(30) not null,
  fid      NUMBER not null,
  obj      NUMBER not null,
  prob     NUMBER not null,
  x        NUMBER not null,
  y        NUMBER not null,
  w        NUMBER not null,
  h        NUMBER not null,
  oid      VARCHAR2(8) not null,
  suppr    NUMBER,
  sid      VARCHAR2(8),
  oup      VARCHAR2(8),
  odn      VARCHAR2(8),
  dtm      DATE,
  fname    VARCHAR2(300),
  oname    VARCHAR2(300),
  exif_ar  NUMBER,
  exif_iw  NUMBER,
  exif_ih  NUMBER,
  oxx      VARCHAR2(8)
)
nologging;
create unique index DET_BC10XX_UI on DET_BC10 (FID, BOORU, OID)
  nologging;

prompt
prompt Creating table DET_PP09
prompt =======================
prompt
create table DET_PP09
(
  batch_id VARCHAR2(8) not null,
  booru    VARCHAR2(30) not null,
  fid      NUMBER not null,
  obj      NUMBER not null,
  prob     NUMBER not null,
  x        NUMBER not null,
  y        NUMBER not null,
  w        NUMBER not null,
  h        NUMBER not null,
  oid      VARCHAR2(8) not null,
  suppr    NUMBER,
  sid      VARCHAR2(8),
  oup      VARCHAR2(8),
  odn      VARCHAR2(8),
  dtm      DATE,
  fname    VARCHAR2(300),
  oname    VARCHAR2(300),
  exif_ar  NUMBER,
  exif_iw  NUMBER,
  exif_ih  NUMBER,
  oxx      VARCHAR2(8)
)
nologging;
create unique index DET_PP09_UI on DET_PP09 (FID, BOORU, OID)
  nologging;

prompt
prompt Creating table DET_XX10
prompt =======================
prompt
create table DET_XX10
(
  batch_id VARCHAR2(8) not null,
  booru    VARCHAR2(30) not null,
  fid      NUMBER not null,
  obj      NUMBER not null,
  prob     NUMBER not null,
  x        NUMBER not null,
  y        NUMBER not null,
  w        NUMBER not null,
  h        NUMBER not null,
  oid      VARCHAR2(8) not null,
  suppr    NUMBER,
  sid      VARCHAR2(8),
  oup      VARCHAR2(8),
  odn      VARCHAR2(8),
  dtm      DATE,
  fname    VARCHAR2(300),
  oname    VARCHAR2(300),
  exif_ar  NUMBER,
  exif_iw  NUMBER,
  exif_ih  NUMBER,
  oxx      VARCHAR2(8)
)
nologging;
create unique index DET_XX10_UI on DET_XX10 (FID, BOORU, OID)
  nologging;

prompt
prompt Creating table DIR_PP09
prompt =======================
prompt
create table DIR_PP09
(
  booru    VARCHAR2(300),
  fid      NUMBER,
  fline    VARCHAR2(4000),
  batch_id CHAR(2)
)
nologging;

prompt
prompt Creating table DIR_XX10
prompt =======================
prompt
create table DIR_XX10
(
  booru VARCHAR2(300),
  fid   NUMBER,
  fline VARCHAR2(4000)
)
nologging;
create index DIR_XX10_I on DIR_XX10 (FID, BOORU)
  nologging;

prompt
prompt Creating table EXIF_PP09
prompt ========================
prompt
create table EXIF_PP09
(
  booru    VARCHAR2(300),
  fid      NUMBER,
  iw       VARCHAR2(48),
  ih       VARCHAR2(48),
  ar       NUMBER,
  px       NUMBER,
  filesize NUMBER,
  jq       NUMBER,
  ifmt     VARCHAR2(30),
  fname    VARCHAR2(300)
)
nologging;

prompt
prompt Creating table EXIF_XX10
prompt ========================
prompt
create table EXIF_XX10
(
  booru    VARCHAR2(300),
  fid      NUMBER,
  iw       VARCHAR2(48),
  ih       VARCHAR2(48),
  ar       NUMBER,
  px       NUMBER,
  filesize NUMBER,
  jq       NUMBER,
  ifmt     VARCHAR2(30),
  fname    VARCHAR2(300)
)
nologging;

prompt
prompt Creating table EXT
prompt ==================
prompt
create table EXT
(
  fline VARCHAR2(4000)
)
organization external
(
  type ORACLE_LOADER
  default directory B
  access parameters 
  (
    RECORDS DELIMITED BY 0x'0A'
    FIELDS TERMINATED BY '>' LDRTRIM
  )
  location (B:'ext.txt')
)
reject limit UNLIMITED;

prompt
prompt Creating table EXT_EXIF
prompt =======================
prompt
create table EXT_EXIF
(
  sourcefile     VARCHAR2(300),
  filecreatedate VARCHAR2(30),
  imagesize      VARCHAR2(12),
  filesize       NUMBER,
  ifmt           VARCHAR2(30),
  jq             VARCHAR2(20)
)
organization external
(
  type ORACLE_LOADER
  default directory B
  access parameters 
  (
    RECORDS DELIMITED BY 0x'0A'
    FIELDS TERMINATED BY ',' optionally enclosed by '"' LDRTRIM
    (
     sourcefile,
     filecreatedate,
     imagesize,
     filesize,
     ifmt,
     jq
     )
  )
  location (B:'exif.txt')
)
reject limit UNLIMITED;

prompt
prompt Creating table STR_BC10
prompt =======================
prompt
create table STR_BC10
(
  booru VARCHAR2(30) not null,
  fid   NUMBER not null,
  h     NUMBER,
  hg    NUMBER,
  hgj   NUMBER,
  b     NUMBER,
  bg    NUMBER,
  bgj   NUMBER,
  s     NUMBER,
  sg    NUMBER,
  sgj   NUMBER,
  hh    VARCHAR2(32767),
  bb    VARCHAR2(32767),
  ss    VARCHAR2(32767),
  havg  NUMBER,
  bavg  NUMBER,
  savg  NUMBER,
  fline VARCHAR2(389),
  ar    NUMBER
)
nologging;
create unique index STR_BC10_UI on STR_BC10 (FID, BOORU)
  nologging;

prompt
prompt Creating table TR_PP09
prompt ======================
prompt
create table TR_PP09
(
  batch_id VARCHAR2(4) not null,
  obj      NUMBER not null,
  x        NUMBER not null,
  y        NUMBER not null,
  w        NUMBER not null,
  h        NUMBER not null,
  fname    VARCHAR2(160),
  oid      VARCHAR2(8) not null,
  booru    VARCHAR2(30) not null,
  fid      NUMBER not null,
  iname    VARCHAR2(260),
  lname    VARCHAR2(160),
  suppr    NUMBER,
  sid      VARCHAR2(8),
  exif_ar  NUMBER
)
nologging;
create unique index TR_PP09_UI on TR_PP09 (FID, BOORU, OID)
  nologging;

prompt
prompt Creating table TR_XX10
prompt ======================
prompt
create table TR_XX10
(
  batch_id VARCHAR2(4) not null,
  obj      NUMBER not null,
  x        NUMBER not null,
  y        NUMBER not null,
  w        NUMBER not null,
  h        NUMBER not null,
  fname    VARCHAR2(160),
  oid      VARCHAR2(8) not null,
  booru    VARCHAR2(30) not null,
  fid      NUMBER not null,
  iname    VARCHAR2(260),
  lname    VARCHAR2(160),
  suppr    NUMBER,
  sid      VARCHAR2(8),
  exif_ar  NUMBER
)
nologging;
create unique index TR_XX10_UI on TR_XX10 (FID, BOORU, OID)
  nologging;

prompt
prompt Creating synonym CMPI
prompt =====================
prompt
create or replace synonym CMPI
  for YOLO.CMPI_XX10;

prompt
prompt Creating synonym CMPO
prompt =====================
prompt
create or replace synonym CMPO
  for YOLO.CMPO_XX10;

prompt
prompt Creating synonym DET
prompt ====================
prompt
create or replace synonym DET
  for YOLO.DET_XX10;

prompt
prompt Creating synonym DETBC
prompt ======================
prompt
create or replace synonym DETBC
  for YOLO.DET_BC10;

prompt
prompt Creating synonym DIR
prompt ====================
prompt
create or replace synonym DIR
  for YOLO.DIR_XX10;

prompt
prompt Creating synonym EXIF
prompt =====================
prompt
create or replace synonym EXIF
  for YOLO.EXIF_XX10;

prompt
prompt Creating synonym STRBC
prompt ======================
prompt
create or replace synonym STRBC
  for YOLO.STR_BC10;

prompt
prompt Creating synonym TR
prompt ===================
prompt
create or replace synonym TR
  for YOLO.TR_XX10;

prompt
prompt Creating package OBJP
prompt =====================
prompt
create or replace package objp as
  type kt is table of number index by varchar2(8);
  k kt;
  function kk ( bb varchar2 ) return number deterministic ;
  type nt is table of varchar2(12) index by varchar2(8);
  n nt;
  function nn ( bb varchar2 ) return varchar2 deterministic ;
  l nt;
  function ll ( bb varchar2 ) return varchar2 deterministic ;
  x nt;
  function xx ( bb varchar2 ) return varchar2 deterministic ;
  function oi ( bo varchar2, ro varchar2 ) return varchar2 ;
end objp ;
/

prompt
prompt Creating view DETBC_J2_V
prompt ========================
prompt
create or replace force view detbc_j2_v as
select f.booru, f.fid, f.oid, b.oid boid, 'U' lvl, f.exif_ar,
       sum(case when f.oid like 'H%' then 1 else 0 end) over (partition by f.booru, f.fid) nn,
       objp.nn(substr(f.batch_id,1,2)||f.obj) fname, round(f.prob,2) prob, round((f.x-f.w/2)*f.exif_iw) x, round((f.y-f.h/2)*f.exif_ih) y, round(f.w*f.exif_iw) w, round(f.h*f.exif_ih) h,
       objp.nn(substr(b.batch_id,1,2)||b.obj) bname, round(b.prob,2) oprob, round((b.x-b.w/2)*b.exif_iw) ox, round((b.y-b.h/2)*b.exif_ih) oy, round(b.w*b.exif_iw) ow, round(b.h*b.exif_ih) oh
  from detbc f
  left join detbc b on f.booru=b.booru and f.fid=b.fid and b.oup=f.oid -- UPPER connection (head to something)
 where f.oid like 'H%' and f.odn is not null and f.exif_ar is not null and f.batch_id like 'XX%'
union
select b.booru, b.fid, b.oid, p.oid boid, 'D' lvl, b.exif_ar,
       sum(case when b.oid like 'B%' then 1 else 0 end) over (partition by b.booru, b.fid) nn,
       objp.nn(substr(b.batch_id,1,2)||b.obj) bname, round(b.prob,2) prob,  round((b.x-b.w/2)*b.exif_iw) x, round((b.y-b.h/2)*b.exif_ih) y, round(b.w*b.exif_iw) w, round(b.h*b.exif_ih) h,
       objp.nn(substr(p.batch_id,1,2)||p.obj) sname, round(p.prob,2) oprob, round((p.x-p.w/2)*p.exif_iw) ox, round((p.y-p.h/2)*p.exif_ih) oy, round(p.w*p.exif_iw) ow, round(p.h*p.exif_ih) oh
  from detbc b
  left join detbc p on p.booru=b.booru and p.fid=b.fid and p.oup=b.oid -- DOWN connection
 where b.oup is not null and b.odn is not null and b.exif_ar is not null and b.batch_id like 'XX%'
union
select f.booru, f.fid, f.oid, 'none' boid, 'N' lvl, f.exif_ar,
       sum(case when f.oid like 'H%' then 100 when f.oid like 'B%' then 10 else 1 end) over (partition by f.booru, f.fid) nn,
       objp.nn(substr(f.batch_id,1,2)||f.obj) fname, round(f.prob,2) prob, round((f.x-f.w/2)*f.exif_iw) x, round((f.y-f.h/2)*f.exif_ih) y, round(f.w*f.exif_iw) w, round(f.h*f.exif_ih) h,
       'none' bname, 0 oprob, 0 ox, 0 oy, 0 ow, 0 oh
 from detbc f
where f.oup is null and f.odn is null and nvl(f.suppr,-1)<0 and f.exif_ar is not null and f.batch_id like 'XX%' -- and f.prob>=0.55 -- NOT CONNECTED
;

prompt
prompt Creating view DETBC_J3_V
prompt ========================
prompt
create or replace force view detbc_j3_v as
select t0.booru, t0.fid, t0.oid, objp.nn('XX'||t0.obj) obj0,
       round(2*abs(nvl(t2.x,t1.x)-t0.x)/(t0.w+nvl(t2.w,t1.w)),2) tilt,
       t0.prob prob0, t0.x x0, t0.y y0, t0.w w0, t0.h h0,
       t1.oid oid1, objp.nn('XX'||t1.obj) obj1, t1.prob prob1, t1.x x1, t1.y y1, t1.w w1, t1.h h1,
       t2.oid oid2, objp.nn('XX'||t2.obj) obj2, t2.prob prob2, t2.x x2, t2.y y2, t2.w w2, t2.h h2,
       count(*) over (partition by t0.booru, t0.fid) nn
  from detbc t0
  left join detbc t1 on t0.booru=t1.booru and t0.fid=t1.fid and t0.odn=t1.oid
  left join detbc t2 on t0.booru=t2.booru and t0.fid=t2.fid and (t0.odn=t2.oid or t1.odn=t2.oid) and t2.oid not in (t0.oid,t1.oid)
 where t0.oid like 'H%' and t0.odn is not null and t0.batch_id like 'XX%' and t0.exif_ar is not null;

prompt
prompt Creating view DET_J2_V
prompt ======================
prompt
create or replace force view det_j2_v as
select f.booru, f.fid, f.oid, b.oid boid, 'U' lvl, f.exif_ar,
       sum(case when f.oid like 'H%' then 1 else 0 end) over (partition by f.booru, f.fid) nn,
       objp.nn(substr(f.batch_id,1,2)||f.obj) fname, round(f.prob,2) prob, round((f.x-f.w/2)*f.exif_iw) x, round((f.y-f.h/2)*f.exif_ih) y, round(f.w*f.exif_iw) w, round(f.h*f.exif_ih) h,
       objp.nn(substr(b.batch_id,1,2)||b.obj) bname, round(b.prob,2) oprob, round((b.x-b.w/2)*b.exif_iw) ox, round((b.y-b.h/2)*b.exif_ih) oy, round(b.w*b.exif_iw) ow, round(b.h*b.exif_ih) oh
  from det f
  left join det b on f.booru=b.booru and f.fid=b.fid and b.oup=f.oid -- UPPER connection (head to something)
 where f.oid like 'H%' and f.odn is not null and f.exif_ar is not null and f.batch_id like 'XX%'
union
select b.booru, b.fid, b.oid, p.oid boid, 'D' lvl, b.exif_ar,
       sum(case when b.oid like 'B%' then 1 else 0 end) over (partition by b.booru, b.fid) nn,
       objp.nn(substr(b.batch_id,1,2)||b.obj) bname, round(b.prob,2) prob,  round((b.x-b.w/2)*b.exif_iw) x, round((b.y-b.h/2)*b.exif_ih) y, round(b.w*b.exif_iw) w, round(b.h*b.exif_ih) h,
       objp.nn(substr(p.batch_id,1,2)||p.obj) sname, round(p.prob,2) oprob, round((p.x-p.w/2)*p.exif_iw) ox, round((p.y-p.h/2)*p.exif_ih) oy, round(p.w*p.exif_iw) ow, round(p.h*p.exif_ih) oh
  from det b
  left join det p on p.booru=b.booru and p.fid=b.fid and p.oup=b.oid -- DOWN connection
 where b.oup is not null and b.odn is not null and b.exif_ar is not null and b.batch_id like 'XX%'
union
select f.booru, f.fid, f.oid, 'none' boid, 'N' lvl, f.exif_ar,
       sum(case when f.oid like 'H%' then 100 when f.oid like 'B%' then 10 else 1 end) over (partition by f.booru, f.fid) nn,
       objp.nn(substr(f.batch_id,1,2)||f.obj) fname, round(f.prob,2) prob, round((f.x-f.w/2)*f.exif_iw) x, round((f.y-f.h/2)*f.exif_ih) y, round(f.w*f.exif_iw) w, round(f.h*f.exif_ih) h,
       'none' bname, 0 oprob, 0 ox, 0 oy, 0 ow, 0 oh
 from det f
where f.oup is null and f.odn is null and nvl(f.suppr,-1)<0 and f.exif_ar is not null and f.batch_id like 'XX%' -- and f.prob>=0.55 -- NOT CONNECTED
;

prompt
prompt Creating view DET_J3_V
prompt ======================
prompt
create or replace force view det_j3_v as
select t0.booru, t0.fid, t0.oid, objp.nn('XX'||t0.obj) obj0,
       round(2*abs(nvl(t2.x,t1.x)-t0.x)/(t0.w+nvl(t2.w,t1.w)),2) tilt,
       t0.prob prob0, t0.x x0, t0.y y0, t0.w w0, t0.h h0,
       t1.oid oid1, objp.nn('XX'||t1.obj) obj1, t1.prob prob1, t1.x x1, t1.y y1, t1.w w1, t1.h h1,
       t2.oid oid2, objp.nn('XX'||t2.obj) obj2, t2.prob prob2, t2.x x2, t2.y y2, t2.w w2, t2.h h2,
       count(*) over (partition by t0.booru, t0.fid) nn
  from det t0
  left join det t1 on t0.booru=t1.booru and t0.fid=t1.fid and t0.odn=t1.oid
  left join det t2 on t0.booru=t2.booru and t0.fid=t2.fid and (t0.odn=t2.oid or t1.odn=t2.oid) and t2.oid not in (t0.oid,t1.oid)
 where t0.oid like 'H%' and t0.odn is not null and t0.batch_id like 'XX%' and t0.exif_ar is not null;

prompt
prompt Creating function FNE
prompt =====================
prompt
CREATE OR REPLACE FUNCTION FNE( p_FullName in varchar2, p_element in varchar2 ) return varchar2 IS
-- fet full file name element
  t_fpath varchar2(300);
  t_fname varchar2(300);
  t_booru varchar2(60);
  t_fid   number;
  t_frest varchar2(300);

PROCEDURE PARSE_FNAME( p_fullname in varchar2, 
                       o_FPath out varchar2, o_FName out varchar2, 
                       o_booru out varchar2, o_fid out number, o_frest out varchar2 ) is
  t_fname varchar2(300);
  t_fid   varchar2(300);
begin
  if p_fullname like '%/%' then 
    o_frest:=replace(p_fullname,'/','\'); 
  else 
    o_frest:=p_fullname; 
  end if;    
  o_frest:=replace(replace(o_frest,CHR(10),''),CHR(13),'');  
  if o_frest like '%\%' then
    o_fname:=substr(o_frest,instr(o_frest,'\',-1)+1);
    o_fpath:=substr(o_frest,1,instr(o_frest,'\',-1)-1);
  else
    o_fname:=o_frest;
    o_fpath:=null;
  end if;
  if o_fname not like '%.___' or length(o_fname)>300 then -- not filename with path ?
    return; 
  end if;
  if o_fname like '____~%' then -- training reordered
    t_fname:=substr(o_fname,6); 
  else 
    t_fname:=o_fname; 
  end if; 
-- BOORU
  o_booru:=null;
  o_fid:=null;
  if t_fname like '% - %' then       -- archive
    o_booru:=lower(substr(t_fname,1,instr(t_fname,' - ')-1));
    o_frest:=substr(t_fname,instr(t_fname,' - ')+3);
  elsif t_fname like 'e-shuushuu.net-%'     then  -- training 1
    o_booru:='e-shuushuu.net';
    o_frest:=substr(t_fname,15);
  elsif t_fname like 'anime-pictures.net-%' then  -- training 2
    o_booru:='anime-pictures.net';
    o_frest:=substr(t_fname,19);
  elsif t_fname like '%-%'                  then  -- training other
    o_booru:=lower(substr(t_fname,1,instr(t_fname,'-')-1));
    o_frest:=substr(t_fname,instr(t_fname,'-')+1);
  end if;
  if nvl(o_booru,'!') not in ('anime-pictures.net','animepaper','badfon','chan.sankakucomplex.com','danbooru.donmai.us',
                              'e-shuushuu.net','e621.net','exnt','gelbooru.com','goodfon','konachan.com','pixiv.sfs',
                              'safebooru.org','tag','tbib.org','walls','www.zerochan.net','yande.re') then 
    o_booru:='!'||o_booru; 
    return; 
  end if;
-- FID
  t_fid:=regexp_substr(regexp_substr(o_frest,'[^\]+$'),'[0-9]+',1,1);
  if t_fid is not null then
    o_fid:=to_number(t_fid);
    o_frest:=substr(o_frest,length(t_fid)+1);
  end if;
  return;
-- if trim(translate(t_fid,'0123456789','          ')) is null then
--   t_frest:=substr(t_frest,1,instr(t_frest,'_',-1)-1);
-- else
--   t_fid:=null;
-- end if;
end PARSE_FNAME;

begin
  PARSE_FNAME(p_FullName,t_FPath,t_FName,t_booru,t_fid,t_frest);
  if    p_element='FPATH' then return t_fpath;
  elsif p_element='FNAME' then return t_fname;
  elsif p_element='BOORU' then return t_booru;
  elsif p_element='FID'   then return t_fid;
  else                         return t_frest;
  end if;

end FNE;
/

prompt
prompt Creating view DIR_BS_EXT_V
prompt ==========================
prompt
create or replace force view dir_bs_ext_v as
select replace(fline,chr(13),'') fline,
       cast(FNE(fline,'FNAME') as varchar2(300)) fname,
       cast(FNE(fline,'FPATH') as varchar2(300)) fpath,
       cast(FNE(fline,'BOORU') as varchar2(300)) booru,
       to_number(FNE(fline,'FID')) fid,
       cast(replace(substr(fline,instr(fline ,'.',-1)+1),chr(13),'') as varchar2(30)) fext
from ext external modify ( location ('dir_bs.txt') );

prompt
prompt Creating view EXIF_EXT_V
prompt ========================
prompt
create or replace force view exif_ext_v as
select cast(FNE(sourcefile,'FNAME') as varchar2(300)) fname,
       cast(FNE(sourcefile,'FPATH') as varchar2(300)) fpath,
       cast(FNE(sourcefile,'BOORU') as varchar2(300)) booru,
       to_number(FNE(sourcefile,'FID')) fid,
       filesize,
       substr(imagesize,1,instr(imagesize,'x')-1) iw, substr(imagesize,instr(imagesize,'x')+1) ih,
       round(substr(imagesize,1,instr(imagesize,'x')-1) / substr(imagesize,instr(imagesize,'x')+1),4) ar,
       substr(imagesize,1,instr(imagesize,'x')-1) * substr(imagesize,instr(imagesize,'x')+1) px,
       to_date(replace(substr(filecreatedate,1,10),':','.')||substr(filecreatedate,11,9),'YYYY.MM.DD HH24:MI:SS') filecreatedate,
       ifmt,
       case when jq  like '<%' then 0 else to_number(replace(jq,chr(13),'')) end jq,
       substr(sourcefile,instr(sourcefile,'.',-1)+1) fext,
       replace(sourcefile,'/','\') fline
from ext_exif
where sourcefile!='SourceFile';

prompt
prompt Creating function IOU
prompt =====================
prompt
create or replace function iou ( x1 number, y1 number, w1 number, h1 number,
                                 x2 number, y2 number, w2 number, h2 number,
                                 inn number default null ) return number as
-- INTERSECTION AREA DETECTION for YOLO-style (relative, centered) boundboxes (x,y,w,h)
-- determine the (noncentered) coordinates of the intersection rectangle
    xa number:=greatest(x1-w1/2,x2-w2/2);
    ya number:=greatest(y1-h1/2,y2-h2/2);
    xb number:=least(x1+w1/2,x2+w2/2);
    yb number:=least(y1+h1/2,y2+h2/2);
    iarea number;
begin
-- compute the area of intersection rectangle
    iarea:=abs(greatest(xB-xA,0)*greatest(yB-yA,0));
    if    iarea=0 then return 0;
-- interesection area related to BOX1
    elsif inn=1   then return round(iarea/(w1*h1),4);
-- interesection area related to BOX2
    elsif inn=2   then return round(iarea/(w2*h2),4);
-- interesection area ABSOLUTE VALUE
    elsif inn=9   then return round(iarea,6);
-- interesection area CLASSIC DEFINITION - default
    else               return round(iarea/(w1*h1+w2*h2-iarea),4);
    end if;
end iou ;
/

prompt
prompt Creating function IOUA
prompt ======================
prompt
create or replace function ioua ( x1 number, y1 number, w1 number, h1 number,
                                  x2 number, y2 number, w2 number, h2 number,
                                  inn number default null ) return number as
-- INTERSECTION AREA DETECTION for BOX-style (relative size) boundboxes (x,y,w,h)
-- determine the (noncentered) coordinates of the intersection rectangle
    xa number:=greatest(x1,x2);
    ya number:=greatest(y1,y2);
    xb number:=least(x1+w1,x2+w2);
    yb number:=least(y1+h1,y2+h2);
    iarea number;
begin
-- compute the area of intersection rectangle
    iarea:=abs(greatest(xB-xA,0)*greatest(yB-yA,0));
    if    iarea=0 then return 0;
-- interesection area related to BOX1
    elsif inn=1   then return round(iarea/(w1*h1),4);
-- interesection area related to BOX2
    elsif inn=2   then return round(iarea/(w2*h2),4);
-- interesection area ABSOLUTE VALUE
    elsif inn=9   then return round(iarea,6);
-- interesection area CLASSIC DEFINITION - default
    else               return round(iarea/(w1*h1+w2*h2-iarea),4);
    end if;
end ioua ;
/

prompt
prompt Creating function IOUJ
prompt ======================
prompt
create or replace function iouj( s_x number, s_y number, s_w number, s_h number,
                                 s_ox number,s_oy number,s_ow number,s_oh number,
                                 f_x number, f_y number, f_w number, f_h number,
                                 f_ox number,f_oy number,f_ow number,f_oh number,
                                 inn number default null ) return number as
-- INTERSECTION AREA DETECTION for YOLOJ-style (absolute pixels) boundboxes pairs
-- s union rectangle
    sxa number:=least(s_x,s_ox);
    sya number:=least(s_y,s_oy);
    sxb number:=greatest(s_x+s_w,s_ox+s_ow);
    syb number:=greatest(s_y+s_h,s_oy+s_oh);
    sw number:=sxb-sxa;
    sh number:=syb-sya;
-- f union rectangle
    fxa number:=least(f_x,f_ox);
    fya number:=least(f_y,f_oy);
    fxb number:=greatest(f_x+f_w,f_ox+f_ow);
    fyb number:=greatest(f_y+f_h,f_oy+f_oh);
    fw number:=fxb-fxa;
    fh number:=fyb-fya;
-- intersection rectangle
    xa number:=greatest(sxa,fxa);
    ya number:=greatest(sya,fya);
    xb number:=least(sxb,fxb);
    yb number:=least(syb,fyb);
    iarea number;
begin
-- compute the area of intersection rectangle
    iarea:=abs(greatest(xB-xA,0)*greatest(yB-yA,0));
    if    iarea=0 then return 0;
-- interesection area related to SBOX
    elsif inn=1   then return round(iarea/(sw*sh),4);
-- interesection area related to FBOX
    elsif inn=2   then return round(iarea/(fw*fh),4);
-- interesection area ABSOLUTE VALUE
    elsif inn=9   then return round(iarea);
-- interesection area CLASSIC DEFINITION - default
    else               return round(iarea/(sw*sh+fw*fh-iarea),4);
    end if;
end iouj ;
/

prompt
prompt Creating function OBJQ
prompt ======================
prompt
create or replace function OBJQ( p_obj number, p_prob number, p_x number, p_y number, p_w number, p_h number,
                                 p_ar number default 1, p_batch varchar2 default 'XX') return varchar2 is
  l_ar number:=round(p_ar*p_w/p_h,2);
  l_ll varchar2(1):=objp.ll(substr(p_batch,1,2)||p_obj);
begin
-- object quality
  if p_batch not like 'XX%' then return 'NOTXX'; end if;
  if p_prob<0.80 and l_ll='H' then return 'BPROH-'||p_prob; end if;                    -- unclear head
  if p_prob<0.72 and p_obj in (1,2,3,4,5,6,7,8)  then return 'BPROS-'||p_prob; end if; -- unclear strong
  if p_prob<0.64 then return 'BPROX-'||p_prob; end if;                                 -- unclear etc
  if p_obj in (13,15) and p_w*p_h<0.01 then return 'BTINYH-'||round(p_w*p_h,4); end if;        -- tiny hip feral
  if p_obj not in (3,4,14) and p_w*p_h<0.0064 then return 'BTINYE-'||round(p_w*p_h,4); end if; -- tiny exception
  if p_w*p_h<0.0036 then return 'BTINY-'||round(p_w*p_h,4); end if;                            -- tiny default
-- border adjusted
  if p_x+p_w/2<0.1 then return 'BBL-'||round(p_x+p_w/2,3); end if;
  if p_y+p_h/2<0.1 then return 'BBU-'||round(p_y+p_h/2,3); end if;
  if p_x-p_w/2>0.9 then return 'BBR-'||round(p_x-p_w/2,3); end if;
  if p_y-p_h/2>0.9 then return 'BBD-'||round(p_y-p_h/2,3); end if;
-- disproportional
  if p_obj in (3,4,11,12) then
    if l_ar not between 0.4 and 1.2+0.3 then return 'BDISE-'||l_ar; else return 'G'; end if; -- shoulders vsplits TALL
  end if;
  if l_ll='H' then
    if l_ar not between 0.6 and 1.6+0.2 then return 'BDISH-'||l_ar; else return 'G'; end if; -- heads (human and some furry)
  end if;
  if p_obj in (9,10,22,23) then
    if l_ar not between 0.8 and 2.4 then return 'BDISS-'||l_ar; else return 'G'; end if;     -- splits jacks WIDE
  end if;
  if p_obj in (13,15) then
    if l_ar not between 0.5 and 2.2 then return 'BDISI-'||l_ar; else return 'G'; end if;     -- feral hip
  end if;
  if p_obj in (14,19) then
    if l_ar not between 0.3 and 3.2 then return 'BDISP-'||l_ar; else return 'G'; end if;     -- wing hrabb
  end if;
  if l_ar not between 0.5 and 2+0.4 then return 'BDIS-'||l_ar; end if;                       -- DEFAULT
  return 'G';
end OBJQ;
/

prompt
prompt Creating procedure DETJ
prompt =======================
prompt
create or replace procedure detj ( pth varchar2, -- file name template to filter
                                   dbg number default 0 ) as -- debug mode
 cc number;
 nn number:=0;
 ll number:=0;
 dl varchar2(200);
 procedure ddbg ( s varchar2 ) is begin if dbg>0 then dbms_output.put_line(s); end if; end ddbg;
begin
-- CLEANUP
  if pth!='%' then -- use %% if you want to clean all
    update det set oup=null, odn=null where fname like pth and (oup is not null or odn is not null);
    dbms_output.put_line('YJ '||pth||' CLEANUP '||SQL%ROWCOUNT);
    commit;
  end if;
-- UPPER
  for cy in ( select f.booru, f.fid,
                     sqrt((b.x-f.x)*(b.x-f.x)*(2*f.exif_ar)+(b.y-f.y)*(b.y-f.y)*decode(sign(f.y-b.y),1,3,1)) dst,
                     f.rowid rid, f.oid, f.x, f.y, sqrt(f.w*f.w+f.h*f.h) sz, f.prob, b.oid boid, b.rowid bowid, sqrt(b.w*b.w+b.h*b.h) bsz
                from det f
                join det b on f.booru=b.booru and f.fid=b.fid and b.obj in (1,2,3,4)
                            and nvl(b.suppr,-1)<0 and b.oup is null and b.batch_id like 'XX%'
               where f.fname like pth and f.oid like 'H%' and f.odn is null and nvl(f.suppr,-1)<0 and f.batch_id like 'XX%'
            order by 1, 2, 3 ) loop
    ll:=ll+1;
    dl:=cy.booru||'-'||cy.fid||': UP '||substr(cy.oid,1,4)||'-'||substr(cy.boid,1,4)||' dst '||round(cy.dst,4)||' sz '||round(cy.sz,3)||' bsz '||round(cy.bsz,3);
    for cj in ( select 'x' from det -- recheck lower, no loop if already joined
                 where rowid=cy.bowid and oup is null ) loop
      select count(*) into cc from det where rowid=cy.rid and odn is not null ; -- recheck upper if already joined
      dl:=dl||' RCHK '||substr(cy.boid,1,4)||'='||cc||' kdst '||round(cy.dst/least(cy.sz,cy.bsz),3)||' ksz '||round(cy.sz/cy.bsz,3);
      if cc=0 and cy.dst<least(cy.sz,cy.bsz)*1.6 and cy.sz/cy.bsz between 0.25 and 4 then -- limit distance and proportion
         update det set odn=cy.boid where rowid=cy.rid ;
         update det set oup=cy.oid where rowid=cy.bowid ;
         dl:=dl||' ++ odn '||substr(cy.boid,1,4)||' oup '||substr(cy.oid,1,4);
         nn:=nn+1;
      end if;
    end loop;
    ddbg(dl);
  end loop;
  dbms_output.put_line('YJ '||pth||' UP '||ll||' >> '||nn);
  commit;
-- LOWER
  ll:=0; nn:=0;
  for cy in ( select f.booru, f.fid,
                     sqrt((b.x-f.x)*(b.x-f.x)*(2*f.exif_ar)+(b.y-f.y)*(b.y-f.y)*decode(sign(f.y-b.y),1,3,1)) dst,
                     f.rowid rid, f.oid, f.x, f.y, sqrt(f.w*f.w+f.h*f.h) sz, f.prob, b.oid boid, b.rowid bowid, sqrt(b.w*b.w+b.h*b.h) bsz
               from det f
               join det b on f.booru=b.booru and f.fid=b.fid and nvl(b.suppr,-1)<0 and b.oup is null
                           and b.oid like 'S%' and b.batch_id like 'XX%'
              where f.fname like pth and f.odn is null and nvl(f.suppr,-1)<0 and f.batch_id like 'XX%'
                and (f.oid like 'H%' or (f.obj in (1,2,3,4) and f.oup is not null))
           order by 1, 2, 3 ) loop
    ll:=ll+1;
    dl:=cy.booru||'-'||cy.fid||': DOWN '||substr(cy.oid,1,4)||'-'||substr(cy.boid,1,4)||' dst '||round(cy.dst,4)||' sz '||round(cy.sz,3)||' bsz '||round(cy.bsz,3);
    for cj in ( select 'x' from det -- recheck lower, no loop if already joined
                 where rowid=cy.bowid and oup is null ) loop
      select count(*) into cc from det where rowid=cy.rid and odn is not null ; -- recheck upper if already joined
      dl:=dl||' RCHK '||substr(cy.boid,1,4)||'='||cc||' kdst '||round(cy.dst/((cy.sz+cy.bsz)*0.5)/*least(cy.sz,cy.bsz)*/,3)||' ksz '||round(cy.sz/cy.bsz,3);
      if cc=0 and ( (cy.oid like 'B%' and cy.dst<((cy.sz+cy.bsz)*0.5)/*least(cy.sz,cy.bsz)*/*2.4) or (cy.oid like 'H%' and cy.dst<least(cy.sz,cy.bsz)*3.2))
              and cy.sz/cy.bsz between 0.25 and 4 then -- limit distance and proportion, SOME MAGICK NUMBERS HARDCODED HERE
         update det set odn=cy.boid where rowid=cy.rid ;
         update det set oup=cy.oid where rowid=cy.bowid ;
         dl:=dl||' ++ odn '||substr(cy.boid,1,4)||' oup '||substr(cy.oid,1,4);
         nn:=nn+1;
      end if;
    end loop;
    ddbg(dl);
  end loop;
  dbms_output.put_line('YJ '||pth||' DOWN '||ll||' >> '||nn);
  commit;
-- unjoined furry head to FERAL
  ll:=0; nn:=0;
  for cy in ( select f.booru, f.fid,
                     sqrt((b.x-f.x)*(b.x-f.x)*(2*f.exif_ar)+(b.y-f.y)*(b.y-f.y)*decode(sign(f.y-b.y),1,3,1)) dst,
                     f.rowid rid, f.oid, f.x, f.y, sqrt(f.w*f.w+f.h*f.h) sz, f.prob, b.oid boid, b.rowid bowid, sqrt(b.w*b.w+b.h*b.h) bsz
                from det f
                join det b on f.booru=b.booru and f.fid=b.fid and b.obj in (15) -- feral
                            and nvl(b.suppr,-1)<0 and b.oup is null and b.batch_id like 'XX%'
               where f.fname like pth and f.oid like 'H%' and f.obj not in (0) and f.odn is null and nvl(f.suppr,-1)<0 and f.batch_id like 'XX%'
            order by 1, 2, 3 ) loop
    ll:=ll+1;
    dl:=cy.booru||'-'||cy.fid||': FERAL '||substr(cy.oid,1,4)||'-'||substr(cy.boid,1,4)||' dst '||round(cy.dst,4)||' sz '||round(cy.sz,3)||' bsz '||round(cy.bsz,3);
    for cj in ( select 'x' from det -- recheck lower, no loop if already joined
                 where rowid=cy.bowid and oup is null ) loop
      select count(*) into cc from det where rowid=cy.rid and odn is not null ; -- recheck upper if already joined
      dl:=dl||' RCHK '||substr(cy.boid,1,4)||'='||cc||' kdst '||round(cy.dst/least(cy.sz,cy.bsz),3)||' ksz '||round(cy.sz/cy.bsz,3);
      if cc=0 and cy.dst<least(cy.sz,cy.bsz)*3.2 and cy.sz/cy.bsz between 0.2 and 1 then -- limit distance and proportion
         update det set odn=cy.boid where rowid=cy.rid ;
         update det set oup=cy.oid where rowid=cy.bowid ;
         dl:=dl||' ++ odn '||substr(cy.boid,1,4)||' oup '||substr(cy.oid,1,4);
         nn:=nn+1;
      end if;
    end loop;
    ddbg(dl);
  end loop;
  dbms_output.put_line('YJ '||pth||' FERAL '||ll||' >> '||nn);
  commit;
-- unjoined furry head or FERAL to WING
  ll:=0; nn:=0;
  for cy in ( select f.booru, f.fid,
                     sqrt((b.x-f.x)*(b.x-f.x)*(2*f.exif_ar)+(b.y-f.y)*(b.y-f.y)*decode(sign(f.y-b.y),1,3,1)) dst,
                     f.rowid rid, f.oid, f.x, f.y, sqrt(f.w*f.w+f.h*f.h) sz, f.prob, b.oid boid, b.rowid bowid, sqrt(b.w*b.w+b.h*b.h) bsz
               from det f
               join det b on f.booru=b.booru and f.fid=b.fid and nvl(b.suppr,-1)<0 and b.oup is null
                           and b.obj in (14) and b.batch_id like 'XX%'
              where f.fname like pth and f.odn is null and nvl(f.suppr,-1)<0 and f.batch_id like 'XX%'
                and f.oid not like 'S%' and f.obj not in (0,1,2,3,4,14)
           order by 1, 2, 3 ) loop
    ll:=ll+1;
    dl:=cy.booru||'-'||cy.fid||': WING '||substr(cy.oid,1,4)||'-'||substr(cy.boid,1,4)||' dst '||round(cy.dst,4)||' sz '||round(cy.sz,3)||' bsz '||round(cy.bsz,3);
    for cj in ( select 'x' from det -- recheck lower, no loop if already joined
                 where rowid=cy.bowid and oup is null ) loop
      select count(*) into cc from det where rowid=cy.rid and odn is not null ; -- recheck upper if already joined
      dl:=dl||' RCHK '||substr(cy.boid,1,4)||'='||cc||' kdst '||round(cy.dst/((cy.sz+cy.bsz)*0.5)/*least(cy.sz,cy.bsz)*/,3)||' ksz '||round(cy.sz/cy.bsz,3);
      if cc=0 and ( (cy.oid like 'B%' and cy.dst<((cy.sz+cy.bsz)*0.5)/*least(cy.sz,cy.bsz)*/*2.4) or (cy.oid like 'H%' and cy.dst<least(cy.sz,cy.bsz)*3.2))
              and cy.sz/cy.bsz between 0.25 and 4 then -- limit distance and proportion, SOME MAGICK NUMBERS HARDCODED HERE
         update det set odn=cy.boid where rowid=cy.rid ;
         update det set oup=cy.oid where rowid=cy.bowid ;
         dl:=dl||' ++ odn '||substr(cy.boid,1,4)||' oup '||substr(cy.oid,1,4);
         nn:=nn+1;
      end if;
    end loop;
    ddbg(dl);
  end loop;
  dbms_output.put_line('YJ '||pth||' WING '||ll||' >> '||nn);
  commit;


end detj;
/

prompt
prompt Creating procedure NMSCMP
prompt =========================
prompt
create or replace procedure nmscmp ( pth varchar2 ) as
begin
-- CLEANUP last run
  update det set sid=null, suppr=null where nvl(fname,'%') like pth and suppr<0;
  if SQL%ROWCOUNT>0 then
    dbms_output.put_line('NMSCMP '||pth||' CLEANUP '||SQL%ROWCOUNT);
    commit;
  end if;

-- ZERO pass
  merge into det o using (
    select booru, fid, oid, max(suid) suid, max(suppr) suppr from (
      select a.booru, a.fid, a.oid, 10000+100*b.obj+a.obj suppr,
             first_value(b.oid) over (partition by a.booru, a.fid, b.oid order by iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h) desc ) suid
       from det a
       join tr b on a.booru=b.booru and a.fid=b.fid and substr(a.batch_id,1,2)=substr(b.batch_id,1,2)
                   and ( iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h)>0.95 and
                         iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h,1)>0.95 and
                         iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h,2)>0.95 )
       where a.suppr is null and b.obj>=0
      ) group by booru, fid, oid
    ) n on (n.fid=o.fid and n.booru=o.booru and o.oid=n.oid)
  when matched then update set o.suppr=-1*n.suppr, O.SID=n.suid
  where o.suppr is null and o.fname like pth ;
  dbms_output.put_line('0.95='||SQL%ROWCOUNT);
  commit;
-- 1-st pass
  merge into det o using (
    select booru, fid, oid, max(suid) suid, max(suppr) suppr from (
      select a.booru, a.fid, a.oid, 20000+100*b.obj+a.obj suppr,
             first_value(b.oid) over (partition by a.booru, a.fid, b.oid order by iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h) desc ) suid
       from det a
       join tr b on a.booru=b.booru and a.fid=b.fid and substr(a.batch_id,1,2)=substr(b.batch_id,1,2)
                   and iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h)>0.9
       where a.suppr is null and b.obj>=0
      ) group by booru, fid, oid
    ) n on (n.fid=o.fid and n.booru=o.booru and o.oid=n.oid)
  when matched then update set o.suppr=-1*n.suppr, O.SID=n.suid
  where o.suppr is null and o.fname like pth ;
  dbms_output.put_line('0.9='||SQL%ROWCOUNT);
  commit;
-- 2-nd pass ==
  merge into det o using (
    select booru, fid, oid, max(suid) suid, max(suppr) suppr from (
      select a.booru, a.fid, a.oid, 30000+100*b.obj+a.obj suppr,
             first_value(b.oid) over (partition by a.booru, a.fid, b.oid order by iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h) desc ) suid
       from det a
       join tr b on a.booru=b.booru and a.fid=b.fid and substr(a.batch_id,1,2)=substr(b.batch_id,1,2)
                   and iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h)>0.8
       where a.suppr is null and b.obj>=0
      ) group by booru, fid, oid
    ) n on (n.fid=o.fid and n.booru=o.booru and o.oid=n.oid)
  when matched then update set o.suppr=-1*n.suppr, O.SID=n.suid
  where o.suppr is null and o.fname like pth ;
  dbms_output.put_line('0.8='||SQL%ROWCOUNT);
  commit;
-- 3-rd pass ==
  merge into det o using (
    select booru, fid, oid, max(suid) suid, max(suppr) suppr from (
      select a.booru, a.fid, a.oid, 40000+100*b.obj+a.obj suppr,
             first_value(b.oid) over (partition by a.booru, a.fid, b.oid order by iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h) desc ) suid
       from det a
       join tr b on a.booru=b.booru and a.fid=b.fid and substr(a.batch_id,1,2)=substr(b.batch_id,1,2)
                   and iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h)>0.7
       where a.suppr is null and b.obj>=0
      ) group by booru, fid, oid
    ) n on (n.fid=o.fid and n.booru=o.booru and o.oid=n.oid)
  when matched then update set o.suppr=-1*n.suppr, O.SID=n.suid
  where o.suppr is null and o.fname like pth ;
  dbms_output.put_line('0.7='||SQL%ROWCOUNT);
  commit;
-- 4-th pass ==
  merge into det o using (
    select booru, fid, oid, max(suid) suid, max(suppr) suppr from (
      select a.booru, a.fid, a.oid, 50000+100*b.obj+a.obj suppr,
             first_value(b.oid) over (partition by a.booru, a.fid, b.oid order by iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h) desc ) suid
       from det a
       join tr b on a.booru=b.booru and a.fid=b.fid and substr(a.batch_id,1,2)=substr(b.batch_id,1,2)
                   and iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h)>0.6
       where a.suppr is null and b.obj>=0
      ) group by booru, fid, oid
    ) n on (n.fid=o.fid and n.booru=o.booru and o.oid=n.oid)
  when matched then update set o.suppr=-1*n.suppr, O.SID=n.suid
  where o.suppr is null and o.fname like pth ;
  dbms_output.put_line('0.6='||SQL%ROWCOUNT);
  commit;
end nmscmp;
/

prompt
prompt Creating procedure NMSDET
prompt =========================
prompt
create or replace procedure nmsdet ( pth varchar2 default '%' , crs number default 0 ) as
-- NON MAXIMUM SUPPRESSION for DETECTIONS
--   for files mask "pth"
--   crossbatches if "crs"
-- NOTE booru+fid+oid is unique, index starts from fid
begin
-- CLEANUP last run
  if pth!='%' then -- use %% if you want to clean all
    update det set sid=null, suppr=null where nvl(fname,'%') like pth and (sid is not null or suppr is not null);
    dbms_output.put_line('NMSDET '||pth||'-'||crs||' CLEANUP '||SQL%ROWCOUNT);
    commit;
  end if;

-- ZERO pass
  merge into det o using (
    select booru, fid, boid, max(suid) suid, max(suppr) suppr from (
      select a.booru, a.fid, a.oid, b.oid boid, 10000+100*b.obj+a.obj suppr,
             first_value(a.oid) over (partition by a.booru, a.fid, b.oid order by iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h) desc ) suid
       from det a
       join det b on a.booru=b.booru and a.fid=b.fid and a.oid!=b.oid and (a.batch_id=b.batch_id or crs!=0)-- INTERNAL
                   and (a.prob>b.prob or (a.prob=b.prob and a.oid>b.oid))
                   and ( iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h)>0.88 and
                         iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h,1)>0.95 and
                         iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h,2)>0.95 )
                   and b.suppr is null and b.fname like pth
      where a.suppr is null and a.fname like pth
      ) group by booru, fid, boid
    ) n on (n.fid=o.fid and n.booru=o.booru and o.oid=n.boid)
  when matched then update set o.sid=n.suid, o.suppr=n.suppr
  where o.suppr is null and o.fname like pth ;
  dbms_output.put_line('1I='||SQL%ROWCOUNT);
  commit;
  merge into det o using (
    select booru, fid, boid, max(suid) suid, max(suppr) suppr from (
      select a.booru, a.fid, a.oid, b.oid boid, 20000+100*b.obj+a.obj suppr,
             first_value(a.oid) over (partition by a.booru, a.fid, b.oid order by iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h) desc ) suid
       from det a
       join det b on a.booru=b.booru and a.fid=b.fid and a.oid!=b.oid and (a.batch_id=b.batch_id or crs!=0) -- INTERNAL
                   and (a.prob>b.prob or (a.prob=b.prob and a.oid>b.oid))
                   and ( iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h)>0.8 and
                         iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h,1)>0.9 and
                         iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h,2)>0.9 )
                   and b.suppr is null and b.fname like pth
      where a.suppr is null and a.fname like pth
      ) group by booru, fid, boid
    ) n on (n.fid=o.fid and n.booru=o.booru and o.oid=n.boid)
  when matched then update set o.sid=n.suid, o.suppr=n.suppr
  where o.suppr is null and o.fname like pth ;
  dbms_output.put_line('2I='||SQL%ROWCOUNT);
  commit;
end nmsdet;
/

prompt
prompt Creating procedure NMSPX
prompt ========================
prompt
create or replace procedure nmsPX ( pth varchar2 default '%' ) as
-- specific "PP inside XX" detections
begin
-- CLEANUP last run
  if pth!='%' then -- use %% if you want to clean all
    update det set oxx=null where nvl(fname,'%') like pth and oxx is not null ;
    dbms_output.put_line('nmsPX '||pth||' CLEANUP '||SQL%ROWCOUNT);
    commit;
  end if;

  merge into det o using (
    select booru, fid, oid, max(boid) boid from (
        select a.booru, a.fid, a.oid,
               first_value(b.oid) over (partition by a.booru, a.fid, b.oid order by iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h, 1) desc ) boid
               -- a.obj, a.prob, ynmsp.nn('PP'||a.obj) oname, b.obj bobj, b.prob bprob, ynmsp.nn('XX'||b.obj) bname,
               -- iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h,1) iou1
         from det a
         join det b on a.booru=b.booru and a.fid=b.fid
                      and b.batch_id like 'XX%' -- CROSS
                      and iou (a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h, 1)>0.01
        where a.oxx is null and a.batch_id like 'PP%' and a.fname like pth
      ) group by booru, fid, oid
    ) n on (n.fid=o.fid and n.booru=o.booru and o.oid=n.oid)
  when matched then update set o.oxx=n.boid
  where o.fname like pth ;
  dbms_output.put_line('I='||SQL%ROWCOUNT);
  commit;
end nmsPX;
/

prompt
prompt Creating package body OBJP
prompt ==========================
prompt
create or replace package body objp as

function kk ( bb varchar2 ) return number deterministic is
begin
   if bb is null then return null; end if;
   return k(bb);
end kk;

function nn ( bb varchar2 ) return varchar2 deterministic is
begin
   if bb is null then return null; end if;
   return n(bb);
end nn;

function ll ( bb varchar2 ) return varchar2 deterministic is
begin
   if bb is null then return null; end if;
   return l(bb);
end ll;

function xx ( bb varchar2 ) return varchar2 deterministic is
begin
   if bb is null then return null; end if;
   return x(bb);
end xx;

function oi ( bo varchar2, ro varchar2 ) return varchar2 is
begin
  if bo is null then return null; end if;
  return l(bo)||dbms_utility.get_hash_value(bo||ro,1000000,8388608);
end oi;

begin
  k('PP0'):=1.0;  n('PP0'):='pns';     l('PP0'):='P';    x('PP0'):=2.0;
  k('PP1'):=1.0;  n('PP1'):='spr';     l('PP1'):='V';    x('PP1'):=1.0;
  k('PP2'):=1.0;  n('PP2'):='ptr';     l('PP2'):='X';    x('PP2'):=2.5;
  k('PP3'):=1.0;  n('PP3'):='fng';     l('PP3'):='V';    x('PP3'):=1.5;
  k('PP4'):=1.0;  n('PP4'):='cun';     l('PP4'):='V';    x('PP4'):=1.0;
  k('PP5'):=1.0;  n('PP5'):='pzu';     l('PP5'):='P';    x('PP5'):=1.0;
  k('PP6'):=1.0;  n('PP6'):='hjb';     l('PP6'):='P';    x('PP6'):=2.0;
  k('PP7'):=1.0;  n('PP7'):='ora';     l('PP7'):='P';    x('PP7'):=1.5;
  k('PP8'):=1.0;  n('PP8'):='trb';     l('PP8'):='V';    x('PP8'):=1.0;

  k('XX0'):=1.0;  n('XX0'):='head';    l('XX0'):='H';    x('XX0'):=0.0;
  k('XX1'):=1.0;  n('XX1'):='bust';    l('XX1'):='B';    x('XX1'):=0.0;
  k('XX2'):=1.0;  n('XX2'):='boob';    l('XX2'):='B';    x('XX2'):=0.2;
  k('XX3'):=1.0;  n('XX3'):='shld';    l('XX3'):='B';    x('XX3'):=0.0;
  k('XX4'):=1.0;  n('XX4'):='sideb';   l('XX4'):='B';    x('XX4'):=0.1;
  k('XX5'):=1.0;  n('XX5'):='belly';   l('XX5'):='S';    x('XX5'):=0.0;
  k('XX6'):=1.0;  n('XX6'):='nopan';   l('XX6'):='S';    x('XX6'):=0.4;
  k('XX7'):=1.0;  n('XX7'):='butt';    l('XX7'):='S';    x('XX7'):=0.0;
  k('XX8'):=1.0;  n('XX8'):='ass';     l('XX8'):='S';    x('XX8'):=0.3;
  k('XX9'):=1.0;  n('XX9'):='split';   l('XX9'):='S';    x('XX9'):=0.0;
  k('XX10'):=1.0; n('XX10'):='sprd';   l('XX10'):='S';   x('XX10'):=0.7;
  k('XX11'):=0.9; n('XX11'):='vsplt';  l('XX11'):='S';   x('XX11'):=0.0;
  k('XX12'):=0.8; n('XX12'):='vsprd';  l('XX12'):='S';   x('XX12'):=0.7;
  k('XX13'):=1.0; n('XX13'):='hip';    l('XX13'):='S';   x('XX13'):=0.0;
  k('XX14'):=0.8; n('XX14'):='wing';   l('XX14'):='B';   x('XX14'):=0.0;
  k('XX15'):=0.9; n('XX15'):='feral';  l('XX15'):='B';   x('XX15'):=0.0;
  k('XX16'):=1.0; n('XX16'):='hdrago'; l('XX16'):='H';   x('XX16'):=0.0; -- 1+15
  k('XX17'):=1.0; n('XX17'):='hpony';  l('XX17'):='H';   x('XX17'):=0.0;
  k('XX18'):=1.0; n('XX18'):='hfox';   l('XX18'):='H';   x('XX18'):=0.0;
  k('XX19'):=1.0; n('XX19'):='hrabb';  l('XX19'):='H';   x('XX19'):=0.0;
  k('XX20'):=1.0; n('XX20'):='hcat';   l('XX20'):='H';   x('XX20'):=0.0;
  k('XX21'):=1.0; n('XX21'):='hbear';  l('XX21'):='H';   x('XX21'):=0.0;
  k('XX22'):=0.9; n('XX22'):='jacko';  l('XX22'):='S';   x('XX22'):=0.0; -- 5+17
  k('XX23'):=0.8; n('XX23'):='jackx';  l('XX23'):='S';   x('XX23'):=0.5;
  k('XX24'):=1.0; n('XX24'):='hhorse'; l('XX24'):='H';   x('XX24'):=0.0;
  k('XX25'):=1.0; n('XX25'):='hbird';  l('XX25'):='H';   x('XX25'):=0.0;

end objp ;
/

prompt
prompt Creating trigger DET_BC10XX_BR
prompt ==============================
prompt
CREATE OR REPLACE TRIGGER 
DET_bc10xx_BR before insert on "DET_BC10" for each row
declare
  -- local variables here
begin
  if :new.booru is null then -- undefined yet
    :new.booru:=FNE(:new.fname,'BOORU');
    :new.fid:=FNE(:new.fname,'FID');
  end if;
  :new.oid:=objp.oi(substr(:new.batch_id,1,2)||:new.obj,:new.prob||:new.x||:new.y||:new.w||:new.h);
end DET_bc10xx_BR;
/

prompt
prompt Creating trigger DET_PP09_BR
prompt ============================
prompt
CREATE OR REPLACE TRIGGER DET_pp09_BR before insert on DET_pp09 for each row
declare
  -- local variables here
begin
  if :new.booru is null then -- undefined yet
    :new.booru:=FNE(:new.fname,'BOORU');
    :new.fid:=FNE(:new.fname,'FID');
  end if;
  :new.oid:=objp.oi(substr(:new.batch_id,1,2)||:new.obj,:new.prob||:new.x||:new.y||:new.w||:new.h);
end DET_pp09_BR;
/

prompt
prompt Creating trigger DET_XX10_BR
prompt ============================
prompt
CREATE OR REPLACE TRIGGER DET_XX10_BR before insert on DET_XX10 for each row
declare
  -- local variables here
begin
  if :new.booru is null then -- undefined yet
    :new.booru:=FNE(:new.fname,'BOORU');
    :new.fid:=FNE(:new.fname,'FID');
  end if;
  :new.oid:=objp.oi(substr(:new.batch_id,1,2)||:new.obj,:new.prob||:new.x||:new.y||:new.w||:new.h);
end DET_XX10_BR;
/

prompt
prompt Creating trigger TR_PP09_BR
prompt ===========================
prompt
CREATE OR REPLACE TRIGGER TR_pp09_BR before insert on TR_pp09 for each row
declare
  -- local variables here
begin
  if :new.booru is null then
    :new.booru:=fne(:new.fname,'BOORU');
    :new.fid:=fne(:new.fname,'FID');
  end if;
  :new.oid:=objp.oi(substr(:new.batch_id,1,2)||:new.obj,:new.x||:new.y||:new.w||:new.h);
end TR_pp09_BR;
/

prompt
prompt Creating trigger TR_XX10_BR
prompt ===========================
prompt
CREATE OR REPLACE TRIGGER TR_XX10_BR before insert on TR_XX10 for each row
declare
  -- local variables here
begin
  if :new.booru is null then
    :new.booru:=fne(:new.fname,'BOORU');
    :new.fid:=fne(:new.fname,'FID');
  end if;
  :new.oid:=objp.oi(substr(:new.batch_id,1,2)||:new.obj,:new.x||:new.y||:new.w||:new.h);
end TR_XX10_BR;
/


prompt Done
spool off
set define on
