@echo off
title HostsTool ������...
mode con: cols=50 lines=16
color 5f
if exist HostsTool.bat del HostsTool.bat
copy down\HostsTool.bat HostsTool.bat
echo ���ڰ�װIPv6����
ipv6 install
echo ��������·�ɣ�
netsh interface ipv6 6to4 set state disabled
netsh interface ipv6 set teredo enterpriseclient teredo.ipv6.microsoft.com 60 34567
netsh interface ipv6 6to4 set state enabled
netsh int ipv6 6to4 set relay 6to4.ipv6.microsoft.com
sc config iphlpsvc start= auto
net start iphlpsvc
netsh interface ipv6 6to4 set state disabled
netsh interface ipv6 set teredo enterpriseclient teredo.ipv6.microsoft.com 60 34567
echo ����ˢ��dns����
ipconfig /flushdns>nul 2>nul
echo ��������IE����...
del /f /s /q "%userprofile%\local Settings\temporary Internet Files\*.*">nul 2>nul
del /f /s /q "%userprofile%\local Settings\temp\*.*">nul 2>nul
del /f /s /q "%userprofile%\recent\*.*">nul 2>nul
del /f /q %userprofile%\recent\*.*>nul 2>nul
ipconfig /flushdns>nul 2>nul
echo        �ָ�IE��������
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /f /v "SearchUrl" /d "https://www.google.com/keyword/%s">nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Search Bar" /d "http://www.google.com/ie" /f>nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Use Search Asst" /d "no" /f>nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchURL" /v "provider" /d "gogl" /f>nul 2>nul
reg add "HKLM\Software\Microsoft\Internet Explorer\" /f /ve /d "about:blank">nul 2>nul
reg add "HKLM\Software\Microsoft\Internet Explorer\Main" /f /v "Search Page" /d "https://www.google.com/intl/zh-CN/">nul 2>nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Search" /v "SearchAssistant" /d "https://www.google.com/ie" /f>nul 2>nul
echo        �޸�IE���������
reg delete "HKLM\Software\Microsoft\Internet Explorer\Extensions" /f>nul 2>nul
reg delete "HKCU\Software\Microsoft\Internet Explorer\Extensions" /f>nul 2>nul
cls
title Enjoy The New Version HostsTool !
mshta vbscript:msgbox("����ʹ���°����߸���һ�����ݣ�",64,"������ɣ�")(window.close)
pause&call HostsTool.bat&del %0