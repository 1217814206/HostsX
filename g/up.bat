@echo off
title HostsTool ������...
mode con: cols=50 lines=16
color 5f
echo ��������������
del ipseccmd.exe HostsTool.bat wget.exe
copy down\ipseccmd.exe ipseccmd.exe>nul 2>nul
copy down\wget.exe wget.exe>nul 2>nul
if exist down\HostsTool.g (copy down\HostsTool.g HostsTool.bat>nul 2>nul) else 
copy down\HostsTool.bat HostsTool.bat>nul 2>nul
echo �ر�DNS client�����Լӿ�DNS�����ٶ�;
echo ���ڰ�װIpv6Э�鼰���֧��,��ʹIpv6���ã�
echo ��һ�ΰ�װIpv6ʱ���Ժ�...
net stop "Dnscache">nul 2>nul
sc config Dnscache start= disabled>nul 2>nul
ipv6 install>nul 2>nul
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
reg add "HKLM\Software\Microsoft\Internet Explorer\Main" /f /v "Search Page" /d "https://www.google.com/intl/zh-CN/"
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Search" /v "SearchAssistant" /d "https://www.google.com/ie" /f
reg delete "HKLM\Software\Microsoft\Internet Explorer\Extensions" /f
reg delete "HKCU\Software\Microsoft\Internet Explorer\Extensions" /f
cls
echo ���SOGOU�ѹ���IE������so.dll
regsvr32 /u /s so.dll >nul 2>nul
del /f %windir%\system32\so.dll >nul 2>nul
reg delete HKCR\NetCafeHlp.AddrHelper /f
reg delete HKCR\NetCafeHlp.AddrHelper.1 /f
reg delete "HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks" /v {02AC20DD-5548-4CA7-ACCF-18AFE5A4A072} /f
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{02AC20DD-5548-4CA7-ACCF-18AFE5A4A072} /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{02AC20DD-5548-4CA7-ACCF-18AFE5A4A072}" /f
cls
title Enjoy The New Version HostsTool !
echo ������ϣ�����ʹ���°����߸���һ�����ݣ�
call HostsTool.bat&del %0