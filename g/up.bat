@echo off
title HostsTool ������...
mode con: cols=50 lines=16
color 5f
if exist HostsTool.bat del HostsTool.bat
copy down\HostsTool.bat HostsTool.bat
echo ����ˢ��dns����
ipconfig /flushdns>nul 2>nul
echo ��������IE����...
del /f /s /q "%userprofile%\local Settings\temporary Internet Files\*.*">nul 2>nul
del /f /s /q "%userprofile%\local Settings\temp\*.*">nul 2>nul
del /f /s /q "%userprofile%\recent\*.*">nul 2>nul
del /f /q %userprofile%\recent\*.*>nul 2>nul
ipconfig /flushdns>nul 2>nul
cls
tittle Enjoy The New Version HostsTool !
mshta vbscript:msgbox("������ɣ�����ʹ���°����߸���һ�����ݣ�",64,"Hosts")(window.close)
pause
del %0