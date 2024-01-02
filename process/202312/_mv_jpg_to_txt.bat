@REM -- в текущей JPG скинуть в подпапку к TXT

dir %1\*.txt /b > _.1

C:\Programs\GnuWin32\bin\sed -e s/.txt/.jpg/g _.1 > _.2

FOR /F "USEBACKQ TOKENS=*" %%F IN (_.2) DO MOVE "%%~F" %1

del _.1
del _.2