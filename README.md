# Yolo for BOORU CHARS

Here is an attempt to detect anime/CG character poses and hence scene composition with [Ultralitics YOLOv8](https://github.com/ultralytics/ultralytics) <br>
Detection classes has been built over typical views of torso components on scene, when the feature of YOLO to use box-surrounding context seems very useful <br>

Key torso components covers: <br>
~ head (human and several furry cases) <br>
~ bust area <br>
~ belly-to-hip area <br>
~ some furry specific features <br>
Not so complex pose structure as [COCO keypoints](https://cocodataset.org/#keypoints-2020) is simplify scene interpretation a lot <br>

Two models suppotred now, look [here](models/README.md) for details <br>

The playground datasets are torrent distributed : <br>
~ [BOORU CHARS 2021](https://nyaa.si/view/1384820) <br>
~ [BOORU CHARS 2015](https://nyaa.si/view/1468367) <br>
~ [BOORU CHARS 2022](https://nyaa.si/view/1547662) <br>
~ and also NSFW grabs from imageboards, mentioned there



## text recovery from Kaggle (under construction)

**AA model:**
- has classes 5-13 are for belly area, 1-4 for bust area and a head
- contains pairs of classes for SFW/NSFW equivalents, the division between them is subjective 
- contains adjacent classes, only \"typical\" views trained in each and it's - again - subjective
- not trained (and not performs good) on heavily decorated characters

Uncommon or yet undiscovered views of torso components were intentionally left undetected.

This is the UNION OF ADJACENT MODELS intended to use with external NMS over concurrent detections

### Torso assembling and scene composition

Every object detected may be a part of torso, which can be triplet (head - bust area - belly area) or head-to-any pair
The main criteria for torso assembling is minimal distance between yet unassembled objects but also up-to-down preferred direction
Some limits placed over possible distance and relative size of one torso parts (see PL/SQL source for details)

After detection and torso assembling every image may be described with:
- qualitative construct (how many objects / assemblies of every type found)
  * that naturally lead to clusters and (with some rough quantitive limits) to scene compositions
- quantitive values (positions, sizes, probabilities) for this assemblies
  * to build \"similarity function\" among images with the same (or comparable) construct

With all data in Oracle it's a playground for PL/SQL and DBMS-DATA-MINING package.

### Version 12 (data patch, v11 suffixes) release notes:
Latest train/val labels and SQL code added. Some illustrative JPEGs added.
\nDetections **YYolobn-v11.csv** and joins **YYolojn-v11.csv** replaced.
\n\n### Version 11 (model and data update) release notes:
\n\nAdvanced AL model has been built over AA with much more tilted (dutch angle) training data. Classes was the same.\n

All images in BOORU CHARS 2021 and 2015 processed with AL models in ensemble **YYolobn-v11.csv**\nData to draw boundboxes and joins **YYolojn-v11.csv**

\n\n### Version 10 (major model update) release notes:\n\nCommon AA model intended to replace union of models (FF+PP+SS) and add new \"hip\" class (\"jacko\" class lost).

\nAll images in BOORU CHARS 2021 and 2015 were processed with new models in ensemble (data replaced with V11).

\n\n### Version 9 (major data update) release notes:\n\nThis is a last and best version with separate models (with no version suffix in pt files).

\nMost of models trained over \"medium\" base model yolov5m and a \"small\" one yolov5s.

\nBigger model not always performs better, when enough resources use a pair of models in ensemble .

\n\nDetections and joins over BOORU CHARS 2021 dataset:\n- portrait aspect ratios 1x2, 3x4 and 7x10 with 3 \"small\" models : YYolob2-v9.csv , 
joins YYoloj2-v9.csv\n- landscape aspect ratios 3x2 and 1x1 (3 \"small\" + 2 \"medium\" models) YYolob3-v9.csv , joins YYoloj3-v9.csv.
\n  * note large count of suppressed detections due to 2+2+1 models concurrently used

### Basic data structures
\n\n**YOLOB detections and assembling data**
\n* batch_id - model short name, suffix \"M\" indicates \"medium\" base model
\n* booru+fid - image ID\n* obj - class number inside model as described above, suffix \"m\" refer to \"medium\" model
\n* oid - object ID unique within image (some hash)\n

* prob - probability\n

* x, y, w, h - bounbox, relative values \n

* suppr - suppression stage (empty for survived objects, look into PL/SQL code for possible values)\n
* sid - suppressed by OID\n

* oup - torso assembling \"upper\" OID (head for bust level, bust for belly level)\n

* odn - torso assembling \"down\" OID (belly for bust level, bust or belly for head)\n\n

**YOLOJ visualisation helper data** with every line shows one join or one orphan object:\n
* fname - BOORU CHARS full file name\n
* booru+fid\n
* hobj, prob, x, y, w, h, oid - info about \"upper\" object, boundbox is in pixels\n

* obj, oprob, ox, oy, ow, oh, boid - info about connected object\n* lvl - \"U\" first connection \"D\" second connection \"N\" not connected \"S\" suppressed\n\n

Simple Python code **yyoloj.py** may be used to draw results over initial images using YOLOJ data.\n\n

### TODO:\n\n

- improve custom NMS with [Weighted Boxes Fusion](https://medium.com/analytics-vidhya/weighted-boxes-fusion-86fad2c6be16)
- improve torso assembling (parameters auto adjusting, etc.)
- ? add more classes (specific for lying poses and/or characters interactions)
- ? train model for hands [using existing dataset](https://www.gwern.net/Crops#hands) despite it's not a \"key torso component\"
- provide BOORU CHAR 2022 dataset with fresh images (800+k in the queue)
- play with classification, clustering and similarity function over imagesets

### TO BE HONEST

There is much more advanced (new, 09.2021) work [Pose Estimation of Illustrated Characters](https://arxiv.org/abs/2108.01819). I can't compete with real pros.
All image copyrights belong to its owner's. My massive copyright violation is not for profit.
Many thanks and respect to imageboard admins and community brought all that treasures online.
