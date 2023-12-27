# PyTorch actual (12.2023) models here

### yolov8s_aa10.pt - general torso components model
 
 0 - head   - anime pretty girl and not only <br>
 1 - bust   - torso part from collarbone center to pair of covered breasts <br>
 2 - boob   - bust with no bra, nipples mostly visible, generally NSFW <br>
 3 - shld   - shoulder and maybe one breast viewed mostly in profile, exactly rear view excluded <br>
 4 - sideb  - uncovered version of shld, with nipples or other NSFW visual marks <br>
 5 - belly  - from belly button to hips half (stocking line), knees below belly, mostly covered <br>
 6 - nopan  - no panty-like clothes on bikini area (regardless of censoring), evidently NSFW belly <br>
 7 - butt   - buttock area visible at least partially from behind, more or less covered, standing or sitting <br>
 8 - ass    - uncovered NSFW version of butt, maybe with pussy visible from behing <br>
 9 - split  - sitting with legs open wide (90+ degrees), typically with at least one knee above belly <br>
10 - sprd   - heavily NSFW version of split <br>
11 - vsplt  - stand split or visually similar pose <br>
12 - vsprd  - heavily NSFW version of vsplit <br>
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
~ torso compopents usually (except hip and jack*) have SFW/NSFW oblect pair <br>
~ upside-down or lying pose detection may work worse than frontal (training set bias) <br>


### yolov8s_pp09.pt - hentai objects and interactions model

All objects in this model are strong NSFW indicators (both for anime and furry) <br>

0 - pns = penis not interacting <br>
1 - spr = spreading { vaginal and anal } not interacting <br>
2 - ptr = penetration { pns + spr interaction } <br>
3 - fng = fingering { spr + hand interaction } <br>
4 - cun = cunnilingus { spr + face interaction } <br>
5 - pzu = paizuri { pns + boobs interaction } <br>
6 - hjb = handjob { pns + hand interaction } <br>
7 - orl = oral / fellatio { pns + face interaction } <br>
8 - trb = tribadism { spr + spr interaction } first implemented in pp09 <br>

Note: <br>
~ you cannot use AA and PP models in ensemble so use it one-by-one or combine results externally <br>
~ PP objects often resides within AA objects, it can be used as a "proof" <br>
~ hard negative mining done to minimize false detections for surely SFW pictures <br>

#### possible improvements

New classes: <br>
~ hrobot - robot mecha head <br>

More instances for better detections: <br>
~ head closeups <br>
~ lying and upside-down scenes <br>

#### other

~ SCALE training hyperparameter changed from 0.5 (default) to 0.6 to cover even bigger/smaller objects <br>
~ all other training hyperparameter are defaults <br>
~ yolo detect train data=E:\AAX\aax.yaml model=yolov8s.pt epochs=80 patience=20 imgsz=640 batch=16 workers=6 project=AAX close_mosaic=10

### CHANGELOG

(12.2023) yolov8s_aa10.pt - magor training dataset update, much more HHORSE and HBIRD, heads with large hats fixed, ETC <br>
(11.2023) yolov8s_aa09.pt - HHORSE and HBIRD classes added <br>
(10.2023) yolov8s_pp09.pt - TRB class added <br>
(08.2023) yolov8s_pp07.pt + yolov8s_aa06.pt - initial versions <br>
