@echo off
set bak=%date:~0,4%��%date:~5,2%��%date:~8,2%��%time:~0,2%ʱ����
for /f "usebackq tokens=1,2,*" %%1 in (`"reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2>nul"^|findstr /i ProductName`) do (set version=%%3)
cls
if exist %ComSpec% goto nt else goto 9x
:9x
set etc=%windir%\
set hosts=%windir%\hosts
goto menu
:nt
if exist %windir%\system32\cmd.exe goto winnt32
if exist %windir%\system64\cmd.exe goto winnt64
:winnt32
set etc=%windir%\system32\drivers\etc
set hosts=%windir%\system32\drivers\etc\hosts
if not exist %windir%\system32\cacls.exe (start /min iexplore http://hostsx.googlecode.com/svn/trunk/lib/cacls32.exe)& (echo δ��⵽ϵͳȨ�������ļ����뱣������ǰĿ¼��)&pause&goto opdp
goto menu
:winnt64
set etc=%windir%\system64\drivers\etc
set hosts=%windir%\system64\drivers\etc\hosts
if not exist %windir%\system64\cacls.exe (start /min iexplore http://hostsx.googlecode.com/svn/trunk/lib/cacls64.exe)& (echo δ��⵽ϵͳȨ�������ļ����뱣������ǰĿ¼��)&pause&goto opdp
goto menu

:menu
color 0b
mode con cols=36 lines=10
echo y|cacls %hosts% /g everyone:f >nul
attrib -r -a -s -h %hosts%
cls
title G+ С����  
echo ---------------------------------
echo  4.��Hosts    G.����Hosts����
echo.   
echo  R.��ԭHosts    U.������G+ Hosts
echo ---------------------------------
echo.
set all=
set /p all=��ѡ�񣬰�[�س�]ˢ��DNS�ͻ��棺
if /i "%all%"=="g" goto dft
if /i "%all%"=="r" goto fixhost
if /i "%all%"=="u" goto chkupdate
if /i "%all%"=="4" goto run
if /i "%all%"=="p" goto perms
if /i "%all%"=="q" goto exit

:dns
echo ��������Dns���� IE����...
ipconfig /flushdns>nul 2>nul
del /f /s /q "%userprofile%\local Settings\temporary Internet Files\*.*">nul 2>nul
del /f /s /q "%userprofile%\local Settings\temp\*.*">nul 2>nul
del /f /s /q "%userprofile%\recent\*.*">nul 2>nul
del /f /q %userprofile%\recent\*.*>nul 2>nul
reg delete "hkcu\Software\Microsoft\MediaPlayer\Services\FaroLatino_CN" /f >nul 2>nul
reg delete "hkcu\Software\Microsoft\MediaPlayer\Subscriptions" /f >nul 2>nul
reg delete "hklm\SOFTWARE\Microsoft\MediaPlayer\services\FaroLatino_CN" /f> nul 2>nul
ipconfig /flushdns>nul 2>nul
goto menu

:dft
echo       ���ڸ���Hosts����
echo.
echo         ...���Ժ�...
call :downvbs
cscript //NoLogo /e:vbscript %temp%/Updates.vbs "http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts">%temp%\HostsX.orzhosts
copy %temp%\HostsX.orzhosts %hosts%
goto perms

:fixhost
color 0c
mode con: cols=50 lines=12
echo �޸�HOSTS�ļ�������ԭϵͳĬ��״̬��
Pause
del %hosts% /q
goto nohosts

:nohosts
echo 127.0.0.1       localhost> %hosts%
echo ::1             localhost>> %hosts%
echo 127.0.0.1 localhost.localdomain localhost>> %hosts%
cls&mshta vbscript:msgbox("Hosts�ļ��ѻָ���ϵͳĬ��״̬",64,"G+ Hosts")(window.close)
goto dns

:chkupdate
color 0d
Mode con cols=50 lines=15
Title ���߸���
cls
echo.
echo                    ���ڼ�����
echo.
echo                    ...���Ժ�...
call :downvbs
cscript //NoLogo /e:vbscript %temp%/Updates.vbs "http://hostsx.googlecode.com/svn/trunk/g/HostsTool.Src">%cd%\HostsToolPro.bat
start %cd%\HostsToolPro.bat
exit

:run
echo y|cacls %hosts% /g everyone:f >nul
attrib -r -a -s -h %hosts%
if not exist %hosts% (call :nohosts) else (start %windir%\notepad.exe %hosts%)
goto perms

:perms
color 0a
title ����Hosts�ļ�����Ȩ��
mode con: cols=50 lines=15
cls
echo.
echo 0.��Ϊֻ����Ĭ��ʹ�ã� F.�޸�Hosts 
echo.
echo 1.����NTFS��ȡȨ��     4.���´�Hosts
echo.
echo 2.����NTFS�ܾ�Ȩ��     5.������
echo.
echo 3.ȡ��NTFSȨ�޿���     6.���ز˵�
SET Choice=
echo.
SET /P Choice=�޸���ɺ���رռ��±�����ѡ��
IF /I '%Choice%'=='0' GOTO readonly
IF /I '%Choice%'=='1' GOTO ntfsr
IF /I '%Choice%'=='2' GOTO ntfsno
IF /I '%Choice%'=='3' GOTO ntfsf
IF /I '%Choice%'=='4' GOTO run
IF /I '%Choice%'=='5' GOTO dns
IF /I '%Choice%'=='6' GOTO menu
IF /I '%Choice%'=='6' GOTO fixhost
:readonly
attrib +r +a +s %hosts%
goto pmfinish
:ntfsr
echo y| cacls %hosts% /c /t /p everyone:f >nul 2>nul
attrib +r -h +s %hosts%  >nul 2>nul
echo y| cacls %hosts% /c /t /p everyone:r >nul
goto pmfinish
:ntfsno
echo y| cacls %hosts% /c /t /p everyone:f >nul 2>nul
attrib %hosts% +r -h +s  >nul 2>nul
echo y| cacls %hosts% /D everyone >nul
goto pmfinish
:ntfsf
echo y| cacls %hosts% /ci /c /t /p administrator:f >nul 2>nul
echo y|cacls %hosts% /g everyone:f >nul
attrib -r -a -s -h %hosts%
goto pmfinish
:pmfinish
echo.
echo Hosts�ļ�Ȩ��������ɣ�
ipconfig /flushdns>nul 2>nul&exit

:downvbs
echo Set oDOM = WScript.GetObject(WScript.Arguments(0)) >%temp%/Updates.vbs
echo do until oDOM.readyState = "complete" >>%temp%/Updates.vbs
echo WScript.sleep 200 >>%temp%/Updates.vbs
echo loop >>%temp%/Updates.vbs
echo WScript.echo oDOM.documentElement.outerText >>%temp%/Updates.vbs