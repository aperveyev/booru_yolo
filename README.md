# YOLOv8 detector for BOORU CHARacters

Here is an attempt to detect anime/CG character poses and hence scene composition <br>
using [Ultralitics YOLOv8](https://github.com/ultralytics/ultralytics) <br>
Detection classes has been built over typical views of torso components on scene, <br>
when the feature of YOLO to use box-surrounding context seems very useful <br>

Key torso components covers: <br>
~ head (human and several furry cases) <br>
~ bust area <br>
~ belly-to-hip area <br>
~ some furry specific features <br>
Not so complex pose structure as [COCO keypoints](https://cocodataset.org/#keypoints-2020) will simplify scene interpretation a lot <br>

General torso components model supported, look [here](models/README.md) for details. <br>
Iterative [process](process/README.md) already led to [impressive dataset and good model metrics](metrics). <br>

Source datasets are distributed via torrent : <br>
~ [BOORU CHARS 2021](https://nyaa.si/view/1384820) <br>
~ [BOORU CHARS 2015](https://nyaa.si/view/1468367) <br>
~ [BOORU CHARS 2022](https://nyaa.si/view/1547662) <br>
~ [BOORU CHARS 2023](https://nyaa.si/view/1740396) also direct URL catalog there <br>

Some (almost) SFW subset of training data is available on [Ultralitics HUB](https://hub.ultralytics.com/datasets/W1NNLLAb9HH7WvWj1nwP) <br>
Browse, download or even use it in-place for DIY training <br>

Detection results over most of BOORU_CHARS stored in [KAGGLE dataset](https://www.kaggle.com/datasets/printcraft/yolov8-torso-detections-over-booru-chars) so we can:<br>
- assemble characters (join nearest head-bust-belly-feature groups) and classify image by scene structure: <br>
  ~ how many characters depicted, what the species are, completeness of character(-s) "assembly" <br>
  ~ scene scale (by biggest or average head size) and depth (by smallest/biggest head size) <br>
  ~ relative and absolute characters positions, detected/implied interactions <br>
- calculate IOU on equivalent objects of structurally comparable images so search for "similar composition" <br>
- compare and/or merge results for several models/versions with the same input <br>

Attention picker (for aa09 model), more examples [here](images09aa) <br>
<br>
![Attention picker](images/1c28005fdf4b262ae894a3da4dfc777cd0b98ac3.jpg)
<br>

Similar composition search, more examples [here](images) <br>
<br>
![Similar composition search](images/BCB_sim_002.jpg)
<br>

This is completely hobbie project, but I can Upwork something more useful if motivated enough <br>
