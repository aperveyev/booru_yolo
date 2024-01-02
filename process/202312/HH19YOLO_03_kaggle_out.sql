set verify off
set termout off
set head off
set feedback off
set pagesize 0
set linesize 4000
set trimspool on
col nnn noprint

spool yolov8s_xx10.tsv

select 'BOORU'||chr(9)||'FID'||chr(9)||'BATCH_ID'||chr(9)||'OBJ'||chr(9)||'PROB'||chr(9)||'X'||chr(9)||'Y'||chr(9)||'W'||chr(9)||'H'||chr(9)||
       'OID'||chr(9)||'OUP'||chr(9)||'ODN'||chr(9)||'OXX'||chr(9)||'AR'||chr(9)||'ONAME' lin 
from dual
/

select booru||chr(9)||fid||chr(9)||batch_id||chr(9)||obj||chr(9)||rtrim(to_char(prob,'FM90.999'),'.')||chr(9)||
       rtrim(to_char(x,'FM90.999'),'.')||chr(9)||rtrim(to_char(y,'FM90.999'),'.')||chr(9)||
       rtrim(to_char(w,'FM90.999'),'.')||chr(9)||rtrim(to_char(h,'FM90.999'),'.')||chr(9)||
       oid||chr(9)||oup||chr(9)||odn||chr(9)||oxx||chr(9)||rtrim(to_char(exif_ar,'FM90.999'),'.')||chr(9)||
       objp.ll(substr(batch_id,1,2)||obj)||lpad(obj,2,'0')||'-'||objp.nn(substr(batch_id,1,2)||obj) lin,
       booru||lpad(fid,11,'0')||batch_id||substr(oid,1,1)||rtrim(to_char(y,'FM90.999'),'.') nnn
from det_bc10
-- where mod(fid,10000)=6666
order by 2
/

spool off

exit
