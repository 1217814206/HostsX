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
echo ��ԭHosts���б��� ...
copy /y %hosts% %etc%\"Hosts��װ_%bf%" >nul 2>nul
echo �������
if exist down\HostsTool.bat goto new 
:new
del HostsTool.bat
copy down\HostsTool.bat HostsTool.bat
pause
cls

:dft
title ���ڸ���Hosts����
mode con: cols=40 lines=10
if not exist wget.exe (echo Wget��������ڣ����������б�����)&pause&exit
echo ���������У����Ժ�... ...
%down% http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts
mshta vbscript:msgbox("�����������ݣ�",64,"Hosts Tool")(window.close)
pause
copy down\HostsX.orzhosts %hosts%
goto finish

:finish
title ����Hosts�ļ�����Ȩ��
mode con: cols=50 lines=15
color 0b
echo 1,��Ϊֻ��
echo 2,����Hosts�ļ���ɾȨ�ޣ�NTFS���̸�ʽ��Ч��
echo 3,�������κ�Ȩ��
SET Choice=
SET /P Choice=�����޸���ɹرռ��±������ѡ�񣬰��س���ȷ�ϣ�
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO readonly
IF /I '%Choice%'=='2' GOTO ntfs
IF /I '%Choice%'=='3' GOTO pmfinish
:readonly
attrib +r +a +s %hosts%
goto pmfinish
:ntfs
attrib +r +a +s %hosts%
echo y|cacls %hosts% /g everyone:r
goto pmfinish
:pmfinish
echo Hosts�ļ�Ȩ��������ɣ�
goto last

:openhosts
start explorer %etc%\
goto menu

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