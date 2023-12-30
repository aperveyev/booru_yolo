# PyTorch actual (12.2023) model

### yolov8s_aa10.pt - mainstream general torso components model
 
 0 - head   - anime pretty girl and not only <br>
 1 - bust   - torso part from collarbone center to pair of covered breasts <br>
 2 - boob   - bust with no bra, nipples mostly visible, generally NSFW <br>
 3 - shld   - shoulder and maybe one breast viewed mostly in profile, exactly rear view excluded <br>
 4 - sideb  - uncovered version of shld, with nipples or other NSFW visual marks <br>
 5 - belly  - from belly button to hips half (stocking line), knees below belly, mostly covered <br>
 6 - nopan  - no panty-like clothes on bikini area (regardless of censoring), evidently NSFW belly <br>
 7 - butt   - buttock area visible at least partially from behind, more or less covered, standing or sitting <br>
 8 - ass    - uncovered NSFW version of butt <br>
 9 - split  - sitting with legs open wide (90+ degrees), typically with at least one knee above belly <br>
10 - sprd   - strongly NSFW version of split <br>
11 - vsplt  - stand split or visually similar pose <br>
12 - vsprd  - strongly NSFW version of vsplit <br>
13 - hip    - full or almost full hip(-s) side view with knee(-s) above belly, usually when sitting or lying <br>
14 - wing   - mostly dragon or pony related <br>
15 - feral  - all-four non-human torso <br>
16 - hdrago - dragon style head <br>
17 - hpony  - pony style head <br>
18 - hfox   - cartoon fox / dog head - Zootopia Nick Wilde <br>
19 - hrabb  - cartoon rabbit head - Zootopia Judy Hopps or bunnygirl <br>
20 - hcat   - cartoon cat or anime catgirl head (less sharp muzzle compared to hfox) <br>
21 - hbear  - cartoon bear head <br>
22 - jacko  - memetic "Jack'O contest pose" with a head toward viewer <br>
23 - jackx  - jacko viewed from behind, sometimes heavily NSFW <br>
24 - hhorse - horse head first implemented in aa09 <br>
25 - hbird - bird head first implemented in aa09 <br>

Note: <br>
~ furry heads are cartoon/art styled (not real animals) trained solely on art images <br>
~ non-head torso compopents usually (except hip and jack*) have SFW/NSFW adjacent oblect pair <br>
~ upside-down or lying pose detection may work worse than for frontal ones (due to training set bias) <br>

**aa10 : 26 classes 60 epoches from XX09**    - mAP50(B) = 0.99241 , mAP50-95(B) = 0.91478 <br>
**aa09 : 26 classes 60 epoches from XX06**    - mAP50(B) = 0.9938 ,  mAP50-95(B) = 0.89652 <br>
**aa06 : 24 classes 90 epoches from yolov8s** - mAP50(B) = 0.98724 , mAP50-95(B) = 0.88405 <br>

#### spinoff models

Training conditions variations may break bottlenecks and pitfalls of a single model <br>
Purging NSFW samples from train+val may exclude adjacent classes collision and make results publicly reproducible <br>
**as01 : 26 classes 80 epoches from yolov8n , SFW training subset** - mAP50(B) = 0.97806 , mAP50-95(B) = 0.85683 <br>
**as02 : 26 classes only 30 epoches from yolov8m , SFW subset**     - mAP50(B) = 0.98694 , mAP50-95(B) = 0.87958 <br>

### Possible improvements

I already have [good results](../metrics), no easy way to improve it substantially - but I keep moving forward ... <br>

Planned classes: <br>
~ hrobot - robot mecha head <br>

Planned dataset improvements: <br>
~ more lying and upside-down scenes <br>
~ more obviously missed objects from BOORU CHARS <br>
~ more head closeups incl. furry muzzles <br>
~ careful feedback cleanup on each [loop](../process/README.md)

Training variations (... oh, resources, my headache ...): <br>
~ chain-train spinoff models <br>
~ tune hyperparameters <br>

#### various hints

SCALE training hyperparameter changed from 0.5 (default) to 0.6 to cover even bigger/smaller objects <br>
all other training hyperparameter are defaults <br>
yolo detect train data=E:\AAX\aax.yaml model=yolov8s.pt epochs=80 patience=20 imgsz=640 batch=16 workers=6 close_mosaic=10

### CHANGELOG

(12.2023) yolov8s_aa10.pt - magor training dataset update: much more HHORSE and HBIRD, heads with large hats fixed<br>
(10.2023) yolov8s_aa09.pt - HHORSE and HBIRD classes added <br>
(08.2023) yolov8s_aa06.pt - initial version for current reincarnation <br>
(12.2022) kicked off from KAGGLE because of TOS violation (NSFW) >> all public descriptions, PTs and run results lost <br>
