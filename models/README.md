# PyTorch actual models here

## TLDR

### yolov8s_aa06.pt - torso components model
 
 0 - head   - all angles incl. faceless rear view
 1 - bust   - from collarbone center to pair of covered breasts
 2 - boob   - bust with no bra, nipples mostly visible, generally NSFW
 3 - shld   - shoulder and maybe one breast viewed mostly in profile, exactly rear view excluded
 4 - sideb  - uncovered version of shld, with nipples or other NSFW visual marks
 5 - belly  - from belly button to hips half (stocking line), knees below belly, mostly covered
 6 - nopan  - no panty-like clothes on bikini area (regardless of censoring), evidently NSFW belly
 7 - butt   - buttock area visible at least partially from behind, more or less covered, standing or sitting
 8 - ass    - uncovered NSFW version of butt, often with pussy visible from behing
 9 - split  - sitting with legs open wide (90+ degrees), mostly with at least one knee above belly
10 - sprd   - heavily NSFW version of split
11 - vsplt  - stand split or visually similar pose
12 - vsprd  - heavily NSFW version of vsplit
13 - hip    - full or almost full hip(-s) side view with knee(-s) above belly, usually when sitting or lying
14 - wing   -   
15 - feral  -  
16 - hdrago - 
17 - hpony  -  
18 - hfox   -   
19 - hrabb  -  
20 - hcat   -   
21 - hbear  -  
22 - jacko  -  
23 - jackx  -  


### yolov8s_pp07.pt - hentai objects and interactions model

All objects here are heavy NSFW indicators.

0 - pns = penis not interacting
1 - spr = spreading { vaginal and anal } not interacting
2 - ptr = penetration { pns + spr interaction }
3 - fng = fingering { spr + hand interaction }
4 - cun = cunnilingus { pussy + face interaction }
5 - pzu = paizuri { pns + boobs interaction }
6 - hjb = handjob { hand + pns interaction }
7 - orl = oral fellatio { pns + face interaction }

Both anime and furry hentai used for training.

Hard negative mining implemented to minimize false detections of surely SFW pictures.
