# Yolo for BOORU characters

Here is an attempt to detect anime/CG character poses and hence scene composition using [Ultralitics YOLOv8](https://github.com/ultralytics/ultralytics) <br>
Detection classes has been built over typical views of torso components on scene, <br>
when the feature of YOLO to use box-surrounding context seems very useful <br>

Key torso components covers: <br>
~ head (human and several furry cases) <br>
~ bust area <br>
~ belly-to-hip area <br>
~ some furry specific features <br>
Not so complex pose structure as [COCO keypoints](https://cocodataset.org/#keypoints-2020) will simplify scene interpretation a lot <br>

We can assemble characters (join nearest head-bust-belly-feature groups) and classify image by content, step by step: <br>
~ how many characters depicted, what the species are, completeness of character(-s) "assembly" <br>
~ scene scale (by biggest or average head size) and depth (by smallest to biggest head size) <br>
~ relative and absolute characters positions, implied interactions <br>
We can calculate IOU for corresponding objects of structurally comparable images so search for "similar composition" <br>

Two separate models supported now - general torso "AA" and heavy NSFW features "PP", look [here](models/README.md) for details <br>

The playground datasets are torrent distributed : <br>
~ [BOORU CHARS 2021](https://nyaa.si/view/1384820) <br>
~ [BOORU CHARS 2015](https://nyaa.si/view/1468367) <br>
~ [BOORU CHARS 2022](https://nyaa.si/view/1547662) <br>
~ [BOORU CHARS 2023](https://nyaa.si/view/1740396) <br>
~ and also grabs from BOORUs mentioned there <br>

Attention picker<br>
<br>
![Attention picker](images/1c28005fdf4b262ae894a3da4dfc777cd0b98ac3.jpg)
<br>

Similar composition search, inspect images for more examples  <br>
<br>
![Similar composition search](images/BCB_sim_002.jpg)
<br>
