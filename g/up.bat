@echo off
title HostsTool ������...
mode con: cols=50 lines=16
color 5f
if exist HostsTool.bat del HostsTool.bat>nul 2>nul
copy down\HostsTool.bat HostsTool.bat>nul 2>nul
echo ���ڰ�װIPv6����
ipv6 install>nul 2>nul
echo ���ڿ���Ipv6���֧�֣�
netsh interface ipv6 6to4 set state disabled>nul 2>nul
netsh interface ipv6 set teredo enterpriseclient teredo.ipv6.microsoft.com 60 34567>nul 2>nul
netsh interface ipv6 6to4 set state enabled>nul 2>nul
netsh int ipv6 6to4 set relay 6to4.ipv6.microsoft.com>nul 2>nul
sc config iphlpsvc start= auto >nul 2>nul
net start iphlpsvc >nul 2>nul
netsh interface ipv6 6to4 set state disabled>nul 2>nul
netsh interface ipv6 set teredo enterpriseclient teredo.ipv6.microsoft.com 60 34567>nul 2>nul
echo ����ˢ��dns����
ipconfig /flushdns>nul 2>nul
echo ��������IE����...
del /f /s /q "%userprofile%\local Settings\temporary Internet Files\*.*">nul 2>nul
del /f /s /q "%userprofile%\local Settings\temp\*.*">nul 2>nul
del /f /s /q "%userprofile%\recent\*.*">nul 2>nul
del /f /q %userprofile%\recent\*.*>nul 2>nul
ipconfig /flushdns>nul 2>nul
echo �ָ�IE��������,�޸�IE���������
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /f /v "SearchUrl" /d "https://www.google.com/keyword/%s"
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Search Bar" /d "http://www.google.com/ie" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Use Search Asst" /d "no" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchURL" /v "provider" /d "gogl" /f
reg add "HKLM\Software\Microsoft\Internet Explorer\" /f /ve /d "about:blank"
reg add "HKLM\Software\Microsoft\Internet Explorer\Main" /f /v "Search Page" /d "https://www.google.com/intl/zh-CN/"
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Search" /v "SearchAssistant" /d "https://www.google.com/ie" /f
reg delete "HKLM\Software\Microsoft\Internet Explorer\Extensions" /f
reg delete "HKCU\Software\Microsoft\Internet Explorer\Extensions" /f
cls
echo ���SOGOU�ѹ���IE������so.dll
regsvr32 /u /s so.dll >nul 2>nul
del /f %windir%\system32\so.dll >nul 2>nul
reg delete HKCR\NetCafeHlp.AddrHelper /f >nul 2>nul
reg delete HKCR\NetCafeHlp.AddrHelper.1 /f >nul 2>nul
reg delete "HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks" /v {02AC20DD-5548-4CA7-ACCF-18AFE5A4A072} /f >nul 2>nul
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{02AC20DD-5548-4CA7-ACCF-18AFE5A4A072} /f >nul 2>nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{02AC20DD-5548-4CA7-ACCF-18AFE5A4A072}" /f >nul 2>nul
cls
title Enjoy The New Version HostsTool !
mshta vbscript:msgbox("����ʹ���°����߸���һ�����ݣ�",64,"������ɣ�")(window.close)
pause&call HostsTool.bat&del %0