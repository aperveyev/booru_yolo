# PyTorch actual models here

## TLDR

### yolov8s_aa06.pt - torso components model
 
 0 - head   - all angles incl. faceless rear view <br>
 1 - bust   - from collarbone center to pair of covered breasts <br>
 2 - boob   - bust with no bra, nipples mostly visible, generally NSFW <br>
 3 - shld   - shoulder and maybe one breast viewed mostly in profile, exactly rear view excluded <br>
 4 - sideb  - uncovered version of shld, with nipples or other NSFW visual marks <br>
 5 - belly  - from belly button to hips half (stocking line), knees below belly, mostly covered <br>
 6 - nopan  - no panty-like clothes on bikini area (regardless of censoring), evidently NSFW belly <br>
 7 - butt   - buttock area visible at least partially from behind, more or less covered, standing or sitting <br>
 8 - ass    - uncovered NSFW version of butt, often with pussy visible from behing <br>
 9 - split  - sitting with legs open wide (90+ degrees), mostly with at least one knee above belly <br>
10 - sprd   - heavily NSFW version of split <br>
11 - vsplt  - stand split or visually similar pose <br>
12 - vsprd  - heavily NSFW version of vsplit <br>
13 - hip    - full or almost full hip(-s) side view with knee(-s) above belly, usually when sitting or lying <br>
14 - wing   -    <br>
15 - feral  -   <br>
16 - hdrago -  <br>
17 - hpony  -   <br>
18 - hfox   -    <br>
19 - hrabb  -   <br>
20 - hcat   -    <br>
21 - hbear  -   <br>
22 - jacko  -   <br>
23 - jackx  -   <br>


### yolov8s_pp07.pt - hentai objects and interactions model

All objects here are heavy NSFW indicators.

0 - pns = penis not interacting <br>
1 - spr = spreading { vaginal and anal } not interacting <br>
2 - ptr = penetration { pns + spr interaction } <br>
3 - fng = fingering { spr + hand interaction } <br>
4 - cun = cunnilingus { pussy + face interaction } <br>
5 - pzu = paizuri { pns + boobs interaction } <br>
6 - hjb = handjob { hand + pns interaction } <br>
7 - orl = oral fellatio { pns + face interaction } <br>

Both anime and furry hentai used for training.

Hard negative mining implemented to minimize false detections of surely SFW pictures.
