@ECHO OFF
del "C:\Program Files\Thunder\Program\MiniXmpInstall.exe"
rd  "C:\Program Files\Thunder\BBInside" /s /q
echo ����ֹͣ����....
net stop "XLDoctor Service"
sc stop XLServicePlatform
ECHO ����ж�ط���....
sc delete "XLDoctor Service"
sc delete XLServicePlatform
ECHO �����
pause 1>nul 2>nul