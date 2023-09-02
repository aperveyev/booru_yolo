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
<br>
<br>
![Attention picker](/images/det_wAL_cr.jpg)
<br>
