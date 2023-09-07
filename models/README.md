# PyTorch actual (08.2023) models here

I need more resources and inspiration to go farther

### yolov8s_aa06.pt - general torso components model
 
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
20 - hcat   - cartoon cat or anime catgirl head <br>
21 - hbear  - cartoon bear head <br>
22 - jacko  - memetic "Jack'O contest pose" with a head toward viewer <br>
23 - jackx  - jacko viewed from behind, sometimes heavily NSFW <br>

Note: <br>
~ furry heads are cartoon/art styled, not real animals <br>
~ a lot of furry heads fall in between of head classes (evidently more classes required) <br>
~ torso compopents usually have SFW/NSFW oblect pair, but no specific NSFW class created for hip <br>
~ upside-down or lying pose detection may work worse than for frontal cases <br>


### yolov8s_pp07.pt - hentai objects and interactions model

All objects in this model are heavy NSFW indicators <br>
Both anime and furry hentai used for training <br>
Hard negative mining implemented to minimize false detections for surely SFW pictures <br>

0 - pns = penis not interacting <br>
1 - spr = spreading { vaginal and anal } not interacting <br>
2 - ptr = penetration { pns + spr interaction } <br>
3 - fng = fingering { spr + hand interaction } <br>
4 - cun = cunnilingus { spr + face interaction } <br>
5 - pzu = paizuri { pns + boobs interaction } <br>
6 - hjb = handjob { pns + hand interaction } <br>
7 - orl = oral fellatio { pns + face interaction } <br>

