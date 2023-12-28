# Workflow insides here

### Toolchain

Main workflow components include: <br>

~ file/image management tools for Windows <br>
  - [FAR namager]() free, powerful, with valuable pluging <br>
  - [exiftool]() for batch image properties calculation <br>
  - [ImageMagick]() for batch conversions, often SQL generated <br>
  - [Fast Stone image viewer]() for interactive analysis and some processing <br>
  - [SED @ GnuWin]() for BAT actions against file lists w/o database <br>
  
~ Python modules and DIY scripts <br>
  - [Ultralitics YOLOv8]() current version, also YOLOv5 used several years ago <br>
  - [labelimg]() for interactive labelling according to YOLO requirements <br>
  
~ free edition of Oracle database and SQLdeveloper <br>
  - all table-like data loaded (sqlldr, external tables) and carefully stored
  - trivial to complex processing with SQL or PL/SQL <br>
  - BAT scripts generated with SQL for sophisticated actions against every file <br>
  - valuable analytic queried and exported to Excel for visualisation

### Database

Note all workflow rely on unique image key (BOORU+FID) placed in file name. <br>
This is a "bridge" between same image incarnations and any related info. <br>

Bird's eye on data structures (all with BOORU+FID): <br>
~ directory listing <br>
~ exiftool results <br>
~ training dataset (with relevant info) <br>
~ detection dataset (with attributes for internal NMS and correlation with training) <br>
~ materialized train-vs-detect datasets (for effective usage and evident presentation) <br>
~ materialized join-torso-components datasets (for effective usage and evident presentation) <br>
There are families of tables with the same structure and _suffixed names. <br>
Processing procedures switch between tables guided by synomyms. <br>

Stored proc: <br>
~ relatively simple functions and metrics <br>
  - Intersect Over Union (for several use-cases) <br>
  - detection "quality" (whether boundbox disproportional and/or border-adjacent and/or low prob) <br>
  - bounbox percentage against image (for several use-cases) <br>
  - models' classes descriptors, data parser helpers, etc <br>
~ batch procedures against data segments <br>
  - Non Maximum Suppression (for several use-cases - inside model, between models, train vs. detect) <br>
  - Torso Components Joiner (for given subset of images) <br>
  - Similar Structured Images Finder (for given input image ID) <br>

Scripts: <br>
~  <br>
~  <br>

### Python

YOLOv8 train/detect commandlines <br>

Detections painter <br>

### Windows shell

Old good BAT tricks <br>
~ directory loop / directories loop (for executible invocation with parameters) <br>
~ file actions against file lists (using SED @ GnuWin) <br>
~  <br>

SQL generated BATs <br>
~ batch copy / rename / move (for file system arrangement, subsetting etc) <br>
~ batch convert <br>
~  <br>
