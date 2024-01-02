
-- get the best of objects from BC to add to dataset
/*+i gnore_row_on_dupkey_index (det, det_ui ) */
insert into det_bc10xx (batch_id, fname, booru, fid, obj, x, y, w, h, prob, oid )
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
         from ext EXTERNAL MODIFY ( LOCATION ('yolodet_BCI_xx10.tsv') ) ) e -- 903.601
where fne(fname,'FID') is not null

-- DETECTIONS set up for procedures
create or replace synonym det for det_bc10xx

-- patch EXIF info
update det y set (exif_iw,exif_ih,exif_ar)=(select min(iw), min(ih), max(round(iw/ih,4)) from booru.bc_v where lower(bc_v.booru)=lower(y.booru) and bc_v.fid=y.fid) where exif_ar is null
select booru, count(*) c from det where exif_ar is null group by booru -- ideally none

-- internal NMS, must be minimal within single model
begin nmsdet('%'); end; 
-- BCB_xx10 1I=34494 2I=2915 @ 91 sec ; BCI 1I=18691 2I=718

-- select * from det where suppr is not null order by prob desc
delete from det where suppr is not null -- IRREVERSIBLE internal duplicates drop
-- delete from det where prob<0.5 -- OPTIONAL, detect run over 0.4

-- torso join (EXIF fields must be not empty !)
begin detj('%',0); end;
-- BCB : UP 2812493 >> 1318633 DOWN 1607505 >> 872973 FERAL 15993 >> 7169 WING 12208 >> 5607 @ 219 sec

-- begin detj('%zero%192478%',1); end; -- debug mode


-- PP inside XX marked in OXX
-- begin yiouPX('%') ; end; -- not migrated yet

-- track single case
select det.*, v.fline from det join booru.bc_v v on v.booru=det.booru and v.fid=det.fid
where det.fid=3935928 -- and batch_id like 'XX%' -- booru='pixiv.sfs'

