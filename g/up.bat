@ECHO OFF
title Hosts ������...
mode con: cols=50 lines=16
color 5f
set bf=%date:~0,4%��%date:~5,2%��%date:~8,2%��%time:~0,2%ʱ����
set down=wget -nH -N -c -q -P down
rem �жϲ���ϵͳ�汾
if exist %ComSpec% goto nt else goto 9x
:9x
set etc=%windir%\
set hosts=%windir%\hosts
goto menu
:nt
set etc=%windir%\system32\drivers\etc
set hosts=%windir%\system32\drivers\etc\hosts
goto menu
:menu
echo y|cacls %hosts% /g everyone:f >nul
attrib -r -a -s -h %hosts%
cls
echo �ر�DNS client�����Լӿ�DNS�����ٶ�;
echo ���ڰ�װIpv6Э��,��ʹipv6���ã�
echo ��������ʹ�á����ɡ���ȡipv6�������֧�֣�
echo http://www.6fei.com.cn/ 
net stop "Dnscache">nul 2>nul
sc config Dnscache start= disabled>nul 2>nul
ipv6 install>nul 2>nul
rem ����IE�����ӵ�ַ��������
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v AutoSearch /t reg_dword /d 00000000 /f>nul 2>nul
rem ����IE��֧��wap��ҳ�����
reg add "HKCU\Software\Classes\MIME\Database\Content Type\text/vnd.wap.wml" /v "CLSID" /d "{25336920-03F9-11cf-8FD0-00AA00686F13}" /f>nul 2>nul
reg add "HKCU\Software\Classes\MIME\Database\Content Type\application/xhtml+xml" /v "CLSID" /d "{25336920-03F9-11cf-8FD0-00AA00686F13}" /f>nul 2>nul
reg add "HKCU\Software\Classes\MIME\Database\Content Type\application/vnd.wap.xhtml+xml" /v "CLSID" /d "{25336920-03F9-11cf-8FD0-00AA00686F13}" /f>nul 2>nul
rem ��ȫģʽ���IE
rem �򿪻����û���������
rem Levels����ֵ����Ϊ
rem 0x10000                  //�������޵�
rem 0x20000                  //���ӻ����û�
rem 0x30000                  //�������޵ģ������û�
rem 0x31000                  //�������޵ģ������û��������ε�
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /v "Levels" /t REG_DWORD /d 0x00030000 /f>nul
echo Windows Registry Editor Version 5.00>%temp%\ie.reg
echo.>>%temp%\ie.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers\0\Paths\{beaeacb1-c258-449b-954f-4ef750406b33}]>>%temp%\ie.reg
echo "LastModified"=hex(b):c4,fb,5e,a3,91,10,c9,01>>%temp%\ie.reg
echo "Description"="����IEΪ�����û��Ĳ���">>%temp%\ie.reg
echo "SaferFlags"=dword:00000000>>%temp%\ie.reg
echo "ItemData"="*\\iexplore.exe">>%temp%\ie.reg
echo.>>%temp%\ie.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers\131072\Paths\{291b2596-e933-443f-843c-643db8cf0b8a}]>>%temp%\ie.reg
echo "LastModified"=hex(b):56,a2,ac,b8,27,b0,c8,02>>%temp%\ie.reg
echo "Description"="����IEΪ�����û��Ĳ���">>%temp%\ie.reg
echo "SaferFlags"=dword:00000000>>%temp%\ie.reg
echo "ItemData"="C:\\Program Files\\Internet Explorer\\*.exe">>%temp%\ie.reg
echo.
regedit /s %temp%\ie.reg
echo 	���ڸ��²��ԣ����Ժ򡭡�
gpupdate /force>nul
cls
echo.
echo 	OK! IE �Ѿ�������Ϊ�����û�Ȩ�ޣ�
echo 	���� IE ������Ѿ����㹻�İ�ȫ�ԣ�
echo.
pause
echo ��ԭHosts���б��� ...
copy /y %hosts% %etc%\"Hosts��װ_%bf%" >nul 2>nul
echo �������
if exist HostsTool.bat del HostsTool.bat
copy down\HostsTool.bat HostsTool.bat
pause
cls
:update
title ���ڸ���Hosts����
mode con: cols=40 lines=10
if not exist wget.exe (echo Wget��������ڣ������°�װ������)&pause&exit
echo ���������У����Ժ�... ...
%down% http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts
echo �����������ݣ�&pause
if not exist down\HostsX.orzhosts goto update
copy down\HostsX.orzhosts %hosts%
title ����Hosts�ļ�ֻ��Ȩ��
attrib +r +a +s %hosts%
echo Hosts�ļ�Ȩ��������ɣ�
goto last

:last
echo Hosts�ļ�Ȩ���������
echo ����ˢ��dns����
ipconfig /flushdns>nul 2>nul
echo ��װ��ɣ�����ʹ�ù����е��ļ�������
del /f /s /q 1.txt clxp.txt go.txt hbhosts.txt host.cab host.zip HOSTS-Optimized.txt.sig hosts.txt hostspath.txt mvps.bat zlnotes.txt zlrepeat.txt ��ֹIP�б�.txt �Զ���.txt
del down\*.* /s/q
del backup\*.* /s/q
rd /s /q backup\
rd /s /q down\hosts\
rd /s /q down\
cls
echo ��������Dns���棬IE����...
reg delete "hkcu\Software\Microsoft\MediaPlayer\Services\FaroLatino_CN" /f>nul 2>nul
reg delete "hkcu\Software\Microsoft\MediaPlayer\Subscriptions" /f>nul 2>nul
reg delete "hklm\SOFTWARE\Microsoft\MediaPlayer\services\FaroLatino_CN" /f>nul 2>nul
del /f /s /q "%userprofile%\local Settings\temporary Internet Files\*.*">nul 2>nul
del /f /s /q "%userprofile%\local Settings\temp\*.*">nul 2>nul
del /f /s /q "%userprofile%\recent\*.*">nul 2>nul
del /f /q %userprofile%\recent\*.*>nul 2>nul
ipconfig /flushdns>nul 2>nul
cls
echo Enjoy Hosts !
pause
del %0