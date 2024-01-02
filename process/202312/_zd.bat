for /d %%s in (*) do 7z a -r -tzip -mx1 "C:\YOLO\%%s" "%%s\*.*"
