@REM -- в текущей TXT скинуть в подпапку к JPG

dir %1\*.jpg /b > _.1

C:\Programs\GnuWin32\bin\sed -e s/.jpg/.txt/g _.1 > _.2

FOR /F "USEBACKQ TOKENS=*" %%F IN (_.2) DO MOVE "%%~F" %1

del _.1
del _.2