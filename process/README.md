# Workflow insides here

### Toolchain

Main workflow components include: <br>
 
~ Python modules and DIY scripts <br>
  - [Ultralitics YOLOv8](https://github.com/ultralytics/ultralytics) current version, also YOLOv5 used several years ago <br>
  - [labelimg](https://github.com/HumanSignal/labelImg) for interactive labelling according to YOLO requirements <br>
  
~ free edition of [Oracle database](https://www.oracle.com/database/free/get-started) and SQLdeveloper <br>
  - all table-like data loaded (sqlldr, external tables) and carefully stored
  - trivial to complex processing with SQL or PL/SQL <br>
  - BAT scripts generated with SQL for sophisticated actions against every file <br>
  - valuable analytic queries exportable to Excel for visualisation <br>

~ file/image management tools for Windows <br>
  - [FAR namager](https://github.com/FarGroup/FarManager) free, powerful, with valuable pluging <br>
  - [exiftool](https://exiftool.org) for batch image properties calculation <br>
  - [ImageMagick](https://imagemagick.org/index.php) for batch conversions, often SQL generated <br>
  - [Fast Stone image viewer](https://www.faststone.org/FSIVDownload.htm) for interactive analysis and some processing, worth to donate it <br>
  - [SED @ GnuWin](https://gnuwin32.sourceforge.net/packages/sed.htm) for BAT actions against file lists w/o database invocation <br>

### Database

Note all workflow rely on unique image key (BOORU+FID) placed in file name. <br>
This is a "bridge" between same image incarnations and any related info. <br>

Bird's eye on data structures (all with BOORU+FID): <br>
~ directory listing <br>
~ exiftool results <br>
~ training dataset (with relevant info) <br>
~ detection dataset (with attributes for internal NMS and correlation with training) <br>
~ materialized train-vs-detect dataset (for effective usage and evident presentation) <br>
~ materialized joined-torso-components dataset (for effective usage and evident presentation) <br>

There are families of tables with the same structure and _suffixed names. <br>
Processing procedures switching between tables guided by synomyms. <br>

Stored PL/SQL proc: <br>

~ relatively simple functions and metrics <br>
  - Intersect Over Union (for several use-cases) <br>
  - detection "quality" (whether boundbox disproportional and/or border-adjacent and/or low prob) <br>
  - bounbox percentage against image (for several use-cases) <br>
  - models' classes descriptors, filename parsers etc <br>

~ batch procedures against data (sub-)sets <br>
  - Non Maximum Suppression (for several use-cases - inside model, between models, train vs. detect) <br>
  - Torso Components Joiner (for given subset of images) <br>
  - Similar Structured Images Finder (for given input image ID) <br>

Scripts (for semi-automatic run): <br>
~ prepare training set to use <br>
~ prepare detection dataset, compare with training and generate derivative data <br>
~ join torso components and generate derivative materialized data 
~ generate copy / move image+label subset BATs for different types of train-det mismatches (review using labelimg)

### Python

YOLOv8 train/detect commandlines <br>

Detections painter <br>

### Windows shell

Old good BAT tricks <br>
~ directory / directories loop (for executible invocation with parameters) <br>
~ file actions against file lists (using SED) <br>

SQL generated BATs <br>
~ batch copy / rename / move (for file system arrangement, subsetting etc) <br>
~ batch convert <br>
~  <br>