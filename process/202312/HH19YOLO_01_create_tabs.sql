create table TR#
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
) ;
-- Create/Recreate indexes 
create unique index TR#_UI on TR# (FID, BOORU, OID) ;

CREATE OR REPLACE TRIGGER TR#_BR before insert on TR# for each row
declare
  -- local variables here
begin
  if :new.booru is null then
    :new.booru:=fne(:new.fname,'BOORU');
    :new.fid:=fne(:new.fname,'FID');
  end if;  
  :new.oid:=objp.oi(substr(:new.batch_id,1,2)||:new.obj,:new.x||:new.y||:new.w||:new.h);
end TR#_BR;
/

create or replace synonym tr for tr# ;

create table DET#
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
);
-- Create/Recreate indexes 
create unique index DET#_UI on DET# (FID, BOORU, OID) ;

CREATE OR REPLACE TRIGGER DET#_BR before insert on DET# for each row
declare
  -- local variables here
begin
  if :new.booru is null then -- undefined yet
    :new.booru:=FNE(:new.fname,'BOORU');
    :new.fid:=FNE(:new.fname,'FID');
  end if;  
  :new.oid:=objp.oi(substr(:new.batch_id,1,2)||:new.obj,:new.prob||:new.x||:new.y||:new.w||:new.h);
end DET#_BR;
/

create or replace synonym det for det# ;
