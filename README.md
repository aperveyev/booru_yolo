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
~ scene scale (by biggest or average head size) and depth (by smallest/biggest head size) <br>
~ relative and absolute characters positions, implied interactions <br>
We can calculate IOU on equivalent objects of structurally comparable images so search for "similar composition" <br>

Two separate models supported - general torso components "AA" and heavy NSFW features "PP", look [here](models/README.md) for details <br>
Use it one-by-one and combine results externally. NSFW classes can help to recheck safety rating assigned on imageboard(-s) <br>

The playground datasets are distributed via torrent : <br>
~ [BOORU CHARS 2021](https://nyaa.si/view/1384820) <br>
~ [BOORU CHARS 2015](https://nyaa.si/view/1468367) <br>
~ [BOORU CHARS 2022](https://nyaa.si/view/1547662) <br>
~ [BOORU CHARS 2023](https://nyaa.si/view/1740396) also URL catalog here <br>

Attention picker (horse head class not implemented yet) <br>
<br>
![Attention picker](images/1c28005fdf4b262ae894a3da4dfc777cd0b98ac3.jpg)
<br>

Similar composition search, inspect images folder for more examples  <br>
<br>
![Similar composition search](images/BCB_sim_002.jpg)
<br>
