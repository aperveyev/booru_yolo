dir Y:\AAP\labels\*.txt /b /s >  dir_bs_%1.txt
dir Y:\AAP\images\*.jpg /b /s >> dir_bs_%1.txt

:exit

exiftool -filecreatedate -imagesize -filesize# -filetype -JPEGQualityEstimate -csv -r Y:\AAP\images\ > exif_pp_%1.txt

:exit

