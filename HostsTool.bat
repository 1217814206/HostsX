@echo off
color 0a
rem ������������
set bf=%date:~0,4%��%date:~5,2%��%date:~8,2%��%time:~0,2%ʱ����
set down=wget -nH -N -c -t 10 -w 2 -q -P down

rem �������Ӱ�����л���֮ǰ���в������ļ�
del /f /s /q echo host hosts>nul 2>nul
del /f /s /q down\*.*>nul 2>nul
del /f /s /q 1.txt clxp.txt go.txt hbhosts.txt HostsX.old ipv6.old hosts.txt hostspath.txt zlnotes.txt zlrepeat.txt ��ֹIP�б�.txt �Զ���.txt>nul 2>nul
del backup\*.* /s/q>nul 2>nul
rd /s /q backup\>nul 2>nul
rd /s /q down\hosts\>nul 2>nul
rd /s /q down\>nul 2>nul

rem Wget����������
if not exist wget.exe ( start /min iexplore http://users.ugent.be/~bpuype/cgi-bin/fetch.pl?dl=wget/wget.exe)& (echo ��������Wget������뱣���ڵ�ǰĿ¼��)&pause else goto sysver 

rem �жϲ���ϵͳ�汾��������ϵͳĬ��Hosts�ļ�λ�õı�����
rem ���Hosts·���жϲ���ȷ������������������find��ʾ��Ȼ���滻�����set hosts=��set etc=��������ݡ�
:sysver
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
goto menu
:winnt64
set etc=%windir%\system64\drivers\etc
set hosts=%windir%\system64\drivers\etc\hosts
goto menu
:find
rem ��ȡϵͳHosts·��
for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DataBasePath" ^|findstr /i "DataBasePath"') do (
	set "DataBasePath=%%b"
)
echo ��ǰϵͳ��Hosts·��Ϊ��
echo %DataBasePath%
echo %DataBasePath%>>hostspath.txt
pause
start %windir%\notepad.exe %0
start %windir%\notepad.exe %~dp0\hostspath.txt
exit

:menu
mode con cols=71 lines=32
rem ϵͳ�ļ����
if not exist cacls.exe (echo ����ϵͳ������ȣ���������ϵͳ�ļ�ȱʧ�������������أ�)&pause&wget -nH -N -c http://hostsx.googlecode.com/svn/trunk/cacls.exe
rem ���Hostsֻ�����ԣ�Ȩ������
echo y|cacls %hosts% /g everyone:f >nul
attrib -r -a -s -h %hosts%
cls
title Hosts С����
echo �������������������������������������������������������������������� ��
echo.��   1.Hosts�ļ�����       2.Acrylic+ ����       3.�����Զ�����      ��
echo �������������������������������������������������������������������� ��
echo.��   4.��Hosts�ļ�       5.Hosts�ļ�����       6.��ȫģʽIE���    ��
echo �������������������������������������������������������������������� ��
echo.��   7.���IE��������ַ    8.ɾ��IE��������ַ    9.IP ��ȫ����       ��
echo ��-------------------------------------------------------------------��
echo.��   B.����Hosts�ļ�       D.ɾ��Hosts����       F.�޸�Hosts�ļ�     ��
echo ��-------------------------------------------------------------------��
echo.��   O.��HostsĿ¼       P.����HostsȨ��       T.IE ֤�����       ��
echo ��-------------------------------------------------------------------��
echo           ������:%date% ����ʱ��:%time%      H.����  
echo �������������������������������������������������������������������� ��
echo ��ǰ����Ŀ¼(0)��%~dp0
echo.
set all=
set /p all=��ѡ����Ӧ�Ĳ�������[�س�]ˢ��DNS�ͻ��棺
if /i "%all%"=="b" goto hostsbak
if /i "%all%"=="c" goto clean
if /i "%all%"=="d" goto delbak
if /i "%all%"=="e" goto delwell
if /i "%all%"=="f" goto fixhosts
if /i "%all%"=="h" goto help
if /i "%all%"=="i" goto iefix
if /i "%all%"=="o" goto openhosts
if /i "%all%"=="p" goto Perms
if /i "%all%"=="t" goto Cert
if /i "%all%"=="u" goto gdft
if /i "%all%"=="v" goto ver
if /i "%all%"=="w" goto find
if /i "%all%"=="1" goto choose
if /i "%all%"=="2" goto Acrylic
if /i "%all%"=="3" goto update
if /i "%all%"=="4" goto run
if /i "%all%"=="5" goto hostsorder
if /i "%all%"=="6" goto safeie
if /i "%all%"=="7" goto addnotrustsite
if /i "%all%"=="8" goto delnotrustsite
if /i "%all%"=="9" goto IPSec
if /i "%all%"=="0" goto opendp
if /i "%all%"=="q" goto exit
if /i "%all%"=="r" goto color

:dns
echo ��������Dns���� IE����...
del /f /s /q "%userprofile%\local Settings\temporary Internet Files\*.*">nul 2>nul
del /f /s /q "%userprofile%\local Settings\temp\*.*">nul 2>nul
del /f /s /q "%userprofile%\recent\*.*">nul 2>nul
del /f /q %userprofile%\recent\*.*>nul 2>nul
ipconfig /flushdns>nul 2>nul
goto menu

:gdft
if not exist down\rd.g call :datadown
cd down\ >nul 2>nul
copy /b rd.g+Site.g+Union.g+Soft.g hbhosts.txt
copy hbhosts.txt %hosts%
cd.. >nul 2>nul
goto Perms

:hostsbak
echo ��ԭHosts���б��� ...
md Bak\
copy /y %hosts% Bak\"Hosts_%bf%" >nul 2>nul
echo �������
pause
goto menu
:delbak
echo �Ƿ�ɾ�����ݵ�Hosts�ļ���
Pause
del %etc%\Hosts_* /q >nul 2>nul
del %etc%\Hosts��װ_* /q >nul 2>nul
del Bak\*.* /q >nul 2>nul
echo ��HostsTool���ݵ�Hosts�ļ���ɾ����
Pause
goto menu
:fixhosts
mode con: cols=50 lines=12
echo �޸�HOSTS�ļ�������ԭϵͳĬ��״̬��
Pause
del %hosts% /q
goto nohosts
:nohosts
mshta vbscript:msgbox("Hosts�ļ��Ҳ�����ɾ��!��",64,"Hosts")(window.close)
pause
echo 127.0.0.1       localhost>> %hosts%
echo ::1             localhost>> %hosts%
echo ��ԭHosts�ļ�ΪϵͳĬ��״̬��
goto run

:run
if not exist %hosts% (call :nohosts) else (start %windir%\notepad.exe %hosts%)
goto Permissions
:openhosts
start explorer %etc%\
goto menu
:opendp
start explorer %~dp0
goto menu

:Perms
title ����Hosts�ļ�����Ȩ��
mode con: cols=50 lines=15
echo 1,��Ϊֻ��
echo 2,����Hosts�ļ���ɾȨ�ޣ�NTFS���̸�ʽ��Ч��
echo 3,[����]�������κ�Ȩ��
SET Choice=
SET /P Choice=�����޸���ɹرռ��±������ѡ�񣬰��س���ȷ�ϣ�
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO readonly
IF /I '%Choice%'=='2' GOTO ntfs
IF /I '%Choice%'=='3' GOTO dns
:readonly
attrib +r +a +s %hosts%
goto pmfinish
:ntfs
attrib +r +a +s %hosts%
echo y|cacls %hosts% /g everyone:r
goto pmfinish
:pmfinish
echo Hosts�ļ�Ȩ��������ɣ�
pause
goto dns

:help
cls
if exist Help.txt type Help.txt|more
start http://hi.baidu.com/iebb
start http://www.uushare.com/user/vokins/file/2559115
mshta vbscript:msgbox("��������Hosts�ļ�����ӹ������ݣ�",64,"Hosts")(window.close)
pause
goto menu

:choose
mode con: cols=63 lines=32
cls
title Hosts ���ݵ���
echo.
echo ��Main Data:                                               
echo.     1.�Ƽ�����            2.IPV6����                      
echo.   
echo ��Single Data:                                             
echo.     4.�������        5.վ�����        6.�������        
echo.   
echo ��Add Plus Data:                                         
echo.     7.�ϸ���ˣ�������ɱ��       8.��ǿ������������     
echo.    
echo ��Mwsl Data:                                              
echo.     M.������վʵ����     F.Formynet      L.���Բ���       
echo.
echo.     V.MVPS        S.SomeOneWhoCares                       
echo.   
echo ��User Data:                                              
echo.     A.���������վ                B.�����Զ�������        
echo.
echo.     C.ɾ��������վ                D.������վ����   
echo.       
echo   -------------------------------------------------------- 
echo  ��������ͬʱ�ظ����ʹ�ö������������Hosts����ӹ������ݣ�
echo   --------------------------------------------------------
echo ��ǰ����λ��(0)��%~dp0
echo.
set all=
set /p all=��ѡ����Ӧ�Ĳ�������[�س�]ˢ��DNS�ͻ��棺
if /i "%all%"=="1" goto dft
if /i "%all%"=="2" goto ipv6
if /i "%all%"=="4" goto union
if /i "%all%"=="5" goto site
if /i "%all%"=="6" goto soft
if /i "%all%"=="7" goto Strict
if /i "%all%"=="8" goto UnionPlus
if /i "%all%"=="a" goto add
if /i "%all%"=="b" goto myfile
if /i "%all%"=="c" goto clear
if /i "%all%"=="d" goto accelerate
if /i "%all%"=="m" goto mwslcn
if /i "%all%"=="f" goto formynet
if /i "%all%"=="l" goto clxp
if /i "%all%"=="v" goto MVPShosts
if /i "%all%"=="s" goto someonewhocares

:dft
echo ���������У����Ժ�... ...
%down% http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts
echo ���������У�&pause
if not exist down\HostsX.orzhosts goto dft
copy down\HostsX.orzhosts %hosts%
goto Perms

:datadown
echo �������ػ��������У����Ժ�... ...
%down% http://hostsx.googlecode.com/svn/trunk/rd.g
%down% http://hostsx.googlecode.com/svn/trunk/Union.g
%down% http://hostsx.googlecode.com/svn/trunk/Site.g
%down% http://hostsx.googlecode.com/svn/trunk/Soft.g
echo ���������У�&pause
if not exist down\rd.g goto datadown

:ipv6
echo �������ػ��������У����Ժ�... ...
%down% http://hostsx.googlecode.com/svn/trunk/ipv6.txt
echo ���������У�&pause
if not exist down\ipv6.txt goto ipv6 &echo ����ʧ�ܣ��������أ�&pause
copy down\ipv6.txt %hosts%
goto Perms

:union
if not exist down\Union.g call :datadown
copy down\Union.g %hosts%
goto Perms

:site
if not exist down\Site.g call :datadown
copy down\Site.g %hosts%
goto Perms

:soft
if not exist down\Soft.g call :datadown
copy down\Soft.g %hosts%
call :wmpclean
goto Permissions

:wmpclean
reg delete "hkcu\Software\Microsoft\MediaPlayer\Services\FaroLatino_CN" /f>nul 2>nul
reg delete "hkcu\Software\Microsoft\MediaPlayer\Subscriptions" /f>nul 2>nul
reg delete "hklm\SOFTWARE\Microsoft\MediaPlayer\services\FaroLatino_CN" /f>nul 2>nul

:Strict
echo ���������У����Ժ�... ...
%down% http://hostsx.googlecode.com/svn/trunk/Strict.txt
pause
copy down\Strict.txt %hosts%
goto Perms

:UnionPlus
echo ���������У����Ժ�... ...
%down% http://hostsx.googlecode.com/svn/trunk/UnionPlus.txt
pause
copy down\UnionPlus.txt %hosts%
goto Perms

:mwslcn
echo ���������У����Ժ�... ...
%down% http://hostsx.googlecode.com/svn/trunk/mwsl.txt
echo ������ɣ��Ƿ�Ҫʹ�� "������վʵ����" �����Hosts���ݣ�
pause
copy down\mwsl.txt %hosts%
goto Perms

:formynet
echo ���������У����Ժ�... ...
%down% http://www.formynet.cn/web/ljwz.txt
echo ������ɣ��Ƿ�Ҫʹ�� "formynet" �����Hosts���ݣ�
pause
copy down\ljwz.txt %hosts%
start http://www.formynet.cn/
goto Perms

:clxp
echo ���������У����Ժ�... ...
%down% ftp://hosts:hosts@clxp.vicp.cc/hosts
copy down\hosts 1.txt
echo.>go.txt
echo **********Clxp������վ�������ݣ��������µ��������û򲡶����ص�ַ��***********>>go.txt
echo ���ڶԶ�����վ���ݽ�������;���......
echo ���Ժ�......
for /f "tokens=1,2 skip=11" %%i in (1.txt) do @echo %%i %%j>>clxp.txt
cls
echo �������! 
echo �Ƿ�Ҫʹ�� "���Բ���" �����Hosts���ݣ�
pause
copy /b go.txt+clxp.txt hbhosts.txt
copy hbhosts.txt %hosts%
goto Perms

:MVPShosts
echo ���������У����Ժ�... ...
%down% http://www.mvps.org/winhelp2002/hosts.txt
echo ������ɣ��Ƿ�Ҫʹ�� "MVPS" �����Hosts���ݣ�
pause
copy down\hosts.txt %hosts%
start http://www.mvps.org/winhelp2002/hosts.htm
goto Perms

:someonewhocares
echo ���������У����Ժ�... ...
%down% http://someonewhocares.org/hosts/hosts
echo ������ɣ��Ƿ�Ҫʹ�� "someonewhocares" �����Hosts���ݣ�
pause
copy down\hosts %hosts%
start http://someonewhocares.org/hosts/
goto Perms

:add
echo �� Ҫ���ΰٶȣ������룺www.baidu.com
set /p a=������Ҫ���ε���վ:
echo 0.0.0.0 %a%>>%hosts%
mshta vbscript:msgbox("%a% �Ѿ������Σ�",64,"Hosts")(window.close)
goto dns

:myfile
echo ��������ʾ�� һ��һ����ÿ�����9���� ǰ����IP��ַ����������վ������0.0.0.0��ɻ���127.0.0.1����>�Զ���.txt
echo 0.0.0.0 www.xxx.com>>�Զ���.txt
start %windir%\notepad.exe �Զ���.txt
echo �����޸���Ϻ�رռ��±�����������һ����
echo ��ע�ⱸ�� �Զ���.txt �еĵ����ݣ�����
echo �Ƿ�Ҫʹ�� "�Զ���.txt" ��Hosts���ݣ�
pause
set "in=>>%hosts%"
for /f "delims=" %%a in (�Զ���.txt) do echo 0.0.0.0%in%
goto Perms

:clear
echo �� Ҫȡ�����ΰٶȣ������룺www.baidu.com
set /p b=������Ҫȡ�����ε���վ:
findstr /i "\<%b%\>"<%hosts%||(cls&echo/&echo ***û���ҵ����������վ��ַ***&pause&goto choose)
findstr /vi "\<%b%\>"<%hosts% >host
del %hosts%
copy host %hosts%
mshta vbscript:msgbox("�Ѿ�ȡ������ %b%��",64,"Hosts")(window.close)
goto dns

:accelerate
set/p c=����Ҫ���ٷ��ʵ�����IP��ַ (�磺192.11.10.69 )
set/p cc= ����Ҫ���ٷ��ʵ��������� (�磺www.baidu.com)
echo %c% %cc%>>%hosts%
mshta vbscript:msgbox("%cc% ���ٷ���������ɣ�",64,"Hosts")(window.close)
goto dns

:Acrylic
mode con: cols=39 lines=25
if not exist Acrylic\ goto :Acrylicerr
NET STOP "Acrylic DNS Proxy Service" > NUL 2> NUL
echo    ==================================
echo          Acrylic DNS Proxy ѡ��
echo    ==================================
echo        1. ˢ�� Acrylic ����
echo.
echo        2. �༭ AcrylicHosts
echo.
echo        3. ��װ Acrylic ����
echo.
echo        4. ���� AcrylicHosts
echo.
echo        5. ж�� Acrylic ����
echo.
echo        D. ɾ�� Acrylic�����ɻָ�����
echo    ==================================
echo.
SET Choice=
SET /P Choice=��ѡ������[0]���أ�
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO AcryPc
IF /I '%Choice%'=='2' GOTO openAcry
IF /I '%Choice%'=='3' GOTO AcrySts
IF /I '%Choice%'=='4' GOTO Acryup
IF /I '%Choice%'=='5' GOTO Acryustl
IF /I '%Choice%'=='d' GOTO delAcry
IF /I '%Choice%'=='0' GOTO menu
:AcryPc
cd Acrylic\ >nul 2>nul
echo    ==================================
ECHO      ˢ�� Acrylic �� ϵͳDNS ����...
DEL /F AcrylicCache.dat > NUL 2> NUL
IPCONFIG /FlushDNS > NUL 2> NUL
echo    ==================================
cd..
goto Acrylast
:openAcry
cd Acrylic\ >nul 2>nul
start %windir%\notepad.exe AcrylicHosts.txt
pause
echo �޸���Ϻ�رռ��±����������������
pause>nul
cd..
goto AcryPc
:AcrySts
cd Acrylic\ >nul 2>nul
echo    ==================================
echo    ���ڰ�װ Acrylic DNS Proxy ����...
AcrylicService.exe /INSTALL /SILENT > NUL 2> NUL
echo    ==================================
cd..
goto Acrylast
:Acrylast
cd Acrylic\ >nul 2>nul
echo    ==================================
echo    �������� Acrylic DNS Proxy ����...
NET START "Acrylic DNS Proxy Service" > NUL
echo    ==================================
cd ..
goto menu
:Acryup
echo    ==================================
echo      ���ڸ��� Acrylic Hosts �ļ� ...
echo    ==================================
wget -nH -N -c http://hostsx.googlecode.com/svn/trunk/AcrylicHosts.txt
echo AcrylicHosts�����Ѹ��£�
pause
goto AcryPc
:Acryustl
cd Acrylic\ >nul 2>nul
echo    ==================================
echo    ����ж�� Acrylic DNS Proxy ����...
AcrylicService.exe /UNINSTALL /SILENT
echo    ==================================
cd ..
goto Acrylic
:delAcry
cd Acrylic\ >nul 2>nul
echo    ����ж�� Acrylic DNS Proxy ����...
AcrylicService.exe /UNINSTALL /SILENT
echo    ���ڽ�������
taskkill /F /IM AcrylicService.exe /T
taskkill /F /IM AcrylicLookup.exe /T
echo    ����ɾ���ļ�
del AcrylicConfiguration.ini AcrylicHosts.txt AcrylicLookup.exe AcrylicService.exe /s/q
cd ..
del Acrylic\*.* /s/q
rd /s /q Acrylic\
echo ж����ϣ�
pause
goto menu
:Acrylicerr
echo.
echo  Acrylic�ļ���ʧ���޷�����ʹ�ø÷���
echo  �����°�װAcrylic�����
start /min http://goo.gl/Kocp
echo  ��������ء���
pause>nul
goto menu

:update
title ���ڸ���HostsTool
mode con: cols=40 lines=10
if not exist wget.exe (echo Wget��������ڣ����������б�����)&pause&exit
echo �����������ݣ����Ժ�... ...
%down% http://hostsx.googlecode.com/svn/trunk/setup.bat
%down% http://hostsx.googlecode.com/svn/trunk/HostsTool.bat
del setup.bat
copy down\setup.bat setup.bat
mshta vbscript:msgbox("���������У�",64,"Hosts Tool")(window.close)
call setup.bat&exit

:hostsorder
title Hosts�ļ�����
mode con: cols=50 lines=15
echo 1,ɾ���������#��ע��
echo 2,��ɾ���ظ�����
echo 3,ɾ��#��ע�Ͳ�ɾ���ظ�����
echo �˹��ܿ��ܻ���Щ���⡣���Ƽ�ʹ�ã�
SET Choice=
SET /P Choice=��ѡ��
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO delnotes
IF /I '%Choice%'=='2' GOTO delrepeat
IF /I '%Choice%'=='3' GOTO delnandr
IF /I '%Choice%'==''  GOTO menu
:delnotes
copy %hosts% zlnotes.txt
echo ���������У����Ե�...
for /f "tokens=1,2" %%i in (zlnotes.txt) do @echo %%i %%j>>hosts.txt
goto zlfinish
:delrepeat
copy %hosts% zlrepeat.txt
echo ���������У����Ե�...
for /f "tokens=1,2,*" %%i in (zlrepeat.txt) do (
if not defined a%%j set "a%%j=a" &echo %%i %%j %%k>>hosts.txt)
goto zlfinish
:delnandr
copy %hosts% 1.txt
echo ���������У����Ե�...
for /f "tokens=1,2" %%i in (1.txt) do @echo %%i %%j>>go.txt
for /f "tokens=1,2,*" %%i in (go.txt) do (
if not defined a%%j set "a%%j=a" &echo %%i %%j %%k>>hosts.txt)
goto zlfinish
:zlfinish
copy hosts.txt %hosts%
del zlrepeat.txt zlnotes.txt hosts.txt
mshta vbscript:msgbox("Hosts�ļ�������ɣ�",64,"Hosts")(window.close)
goto dns

:addnotrustsite
echo ��������ʾ�� һ��һ����վ������>�Զ���.txt
echo www.forexample.com>>�Զ���.txt
echo example.com>>�Զ���.txt
start %windir%\notepad.exe �Զ���.txt
echo �����޸���Ϻ�رռ��±�����������һ����
echo ��ע�ⱸ�� �Զ���.txt �еĵ����ݣ�����
echo ȷ��Ҫʹ���Զ����IE��������ַ���ݣ�
pause
echo       ������Ӷ�����ַ��������ǰ�ȫ����
echo       ���������Ҫ�����ӣ����Ժ򡭡�
set DMAIN=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet 
Settings\ZoneMap\Domains
for /F %%a in (�Զ���.txt) do reg add "%DMAIN%\%%a" /v * /t REG_DWORD /d 0x00000004 /f >nul
echo       �����ϡ���
pause
goto menu

:delnotrustsite
echo  �Ƿ�Ҫ����IE������ǰ�ȫ�����������ַ��
pause
reg delete "hkcu\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains" 
/f>nul 2>nul
goto menu

:IPSec
mode con: cols=55 lines=18
echo IP ��ȫ���� �����Բ��ķ����������Ѿ�ֹͣ���£��Ƿ������
pause
sc create PolicyAgent binpath= "C:\WINDOWS\system32\lsass.exe" type= share start= auto displayname= "IPSEC Services" depend= RPCSS/IPSec
sc description PolicyAgent "�ṩ TCP/IP �����Ͽͻ��˺ͷ�����֮��˶Զ˵İ�ȫ������˷���ͣ�ã������Ͽͻ��˺ͷ�����֮��� TCP/IP ��ȫ�����ȶ�������˷��񱻽��ã��κ��������ķ����޷�������"
if not exist ipseccmd.exe (echo ����ϵͳ������ȣ���������ϵͳ�ļ�ȱʧ�������������أ�)&pause&wget -nH -N -c http://hostsx.googlecode.com/svn/trunk/ipseccmd.exe
echo ���������У����Ժ�... ...
wget -nH -N -c ftp://hosts:hosts@clxp.vicp.cc/��ֹIP�б�.txt
echo �Ƿ�Ҫʹ�� "���Բ���" �����IP��ȫ���ԣ�
pause
ipseccmd -w reg -p ipsce -y
FOR /f "skip=1 delims= " %%i IN (��ֹIP�б�.txt) DO call set list=%%list%% %%i
ipseccmd -w reg -p ipsec:1 -r filterlist -f %list% -n BLOCK -x >nul
ipseccmd  -w REG -p "ipsec" -x >nul
gpupdate >nul
pause
goto menu

:safeie
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
echo 	������˳�����
pause>nul
goto menu

:iefix
mode con cols=38 lines=23
title ��IE����޸����Ż������һЩ����һʱ�޷����ʵ����⣩
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo    ���ڶ� IE ����޸���ע�ᣬ�Ż�
echo.
echo    ��ȴ�������......   
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
regsvr32 /s actxprxy.dll
echo ��ɰٷ�֮ 10
regsvr32 /s shdocvw.dll
echo ��ɰٷ�֮ 15
regsvr32 /s oleaut32.dll
echo ��ɰٷ�֮ 20
Regsvr32 /s URLMON.DLL
echo ��ɰٷ�֮ 25
Regsvr32 /s mshtml.dll
echo ��ɰٷ�֮ 30
Regsvr32 /s msjava.dll
echo ��ɰٷ�֮ 35
Regsvr32 /s browseui.dll
echo ��ɰٷ�֮ 40
Regsvr32 /s softpub.dll
echo ��ɰٷ�֮ 45
Regsvr32 /s wintrust.dll
echo ��ɰٷ�֮ 50 (�Ż�,��ȴ�)
Regsvr32 /s initpki.dll
echo ��ɰٷ�֮ 55
Regsvr32 /s dssenh.dll
echo ��ɰٷ�֮ 60
Regsvr32 /s rsaenh.dl
echo ��ɰٷ�֮ 65
Regsvr32 /s gpkcsp.dll
echo ��ɰٷ�֮ 70
Regsvr32 /s sccbase.dll
echo ��ɰٷ�֮ 75
Regsvr32 /s slbcsp.dll
echo ��ɰٷ�֮ 85
Regsvr32 /s cryptdlg.dll
echo ��ɰٷ�֮ 90
sfc /purgecache
echo ��ɰٷ�֮ 100
echo .��IE����޸����Ż���ϡ�
Pause.
goto menu

:clean 
title ϵͳ�������
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo  �������ϵͳ�����ļ������Ե�......
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
sfc /purgecache
sfc /purgecache
del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\*.log
del /f /s /q %windir%\*.tmp
del /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
rd /s /q %temp% & md %temp%
del /f /q %userprofile%\recent\*.*
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
del /f /s /q "%userprofile%\recent\*.*"
echo .ϵͳ���������ϡ�
cls
goto menu

:delwell
mode con cols=60 lines=20
echo.
echo 		  �� ����ļ�/Ŀ¼ɾ���� ��
echo 	           -----------------------
echo.
echo  ר�ſ���ɾ�����ֲ��ܴ򿪡����ܽ��롢����ɾ�������Ŀ¼��
echo.
echo 	ע�⣺ɾ��Ŀ¼��ͬʱɾ������Ŀ¼���������ݣ�
echo.
echo.
set Choice=
echo 	�뽫Ҫɾ�������Ŀ¼ֱ�����뱾���ڣ�Ȼ��س�:
echo.
set /p Choice=
if ""%Choice%"" == "" goto menu
echo y|Cacls ""%Choice%"" /c /t /p Everyone:f
DEL /F /A /Q \\?\""%Choice%""
RD /S /Q \\?\""%Choice%"" 
echo.
echo 	ɾ�����! ��������ء���
goto menu

:Cert
certmgr.msc
goto menu

:color
mode con cols=40 lines=18                                
echo      ---------------------------
echo       A.�ڵ�����   B.�ڵ׺�����
echo       C.�ڵװ���   D.���������
echo       E.�ϵװ���   F.���׵׺���
echo       G.�̵װ���   H.�Զ���
echo      ---------------------------
echo.                                     
echo  С��ʾ��
echo ------------------------------------  
echo   0.��ɫ1.��ɫ2.��ɫ3.ǳ��ɫ4.��ɫ
echo ------------------------------------
echo   5.��ɫ6.��ɫ7.��ɫ8.��ɫ9.ǳ��ɫ
echo ------------------------------------
echo A.ǳ��B.ǳ��C.ǳ��D.����E.ǳ��F.����
echo ------------------------------------
set input=s
set /p input=��ѡ�񣬰�[0]����:
if %input%==a (
set ok=1
color 02
 )else (
if /i %input%==b color 03
if /i %input%==c color 07
if /i %input%==d color 4f
if /i %input%==e color 5f
if /i %input%==f color f0
if /i %input%==g color 2f
if /i %input%==h GOTO colormy
if /i %input%==0 GOTO menu
)
goto color
:colormy
set /p a=�����뱳������ɫ����:
set /p b=���������ֵ���ɫ����:
color %a%%b%
pause&goto menu

:ver
mode con cols=45 lines=15
title Thx All Friends Help
echo Version:    1.6 Freeware Version
echo Date:       2010.06.01
echo Purpose:    Hosts��ص�P������
echo COPYRIGHT:  OrzTech, Inc. By ����
mshta vbscript:createobject("sapi.spvoice").speak("Thank U for using and Enjoy it!")(window.close)
pause
goto menu