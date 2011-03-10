@echo off
pushd %~dp0
color 0a
path %windir%\system32
if exist %windir%\system32\mode.com mode con cols=60 lines=25
ConsExt /crv 0
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
set RegOwnr=-ot reg -actn setowner -ownr "n:everyone" -rec yes
set RegFull=-ot reg -actn ace -ace "n:Everyone;p:full;i:so,sc;m:set" -rec yes
set regfile=usbclear.reg
set logfile=usbclear.log
set txtfile=usbclear.txt
set tmpregfile=%temp%\ucreg.tmp
set tmpregkey=%temp%\uckey.tmp
set mode=disp
set force=0
set progname=USBClear v1.0.5 Beta by X
:start
title %progname% - U�̼�¼������
cls
echo.
echo   ������� ����ѡ�����
echo   =======================================================
echo.
echo            �� 1.����Hosts�ļ�   ��
echo.
echo            �� 2.������U�����ע�����   ��
echo.
echo            �� 3.����U�̼�¼ע������ļ� ��
echo.
echo   =======================================================
echo   �������ص㣺 1. ��������ע�����������U����صĸ��ּ�¼
echo                2. ��׼����U����ؼ�¼����Ӱ������USB�豸
echo                3. ��ǿ�����������U����ص�����������¼
echo   =======================================================
echo   ���棺��ȫ����ģʽֻ���������֪U�̵�������¼���л���ǿ
echo         ������ģʽ�󣬿����������п�����U����ص���������
echo         ��¼����������ɾ�������ķ��ա�
echo   =======================================================
echo.
if /i !force! neq 0 (echo   ��ǰģʽ��ǿ������ģʽ) else (echo   ��ǰģʽ����ȫ����ģʽ)
echo.
echo            �� �л�ģʽ ��     ��  ��  ��  ��
:mouse1
ConsExt /event
set /a xy=%errorlevel%
if %xy% lss 1001 goto mouse1
set /a X=%xy:~0,-3%
set /a Y=%xy%-1000*%X%
if %y% equ 4 if %x% gtr  12 if %x% lss 44 set mode=disp&&goto progress
if %y% equ 6 if %x% gtr  12 if %x% lss 44 set mode=del&&goto progress
if %y% equ 8 if %x% gtr  12 if %x% lss 44 set mode=reg&&goto progress
if %y% equ 22 if %x% gtr  12 if %x% lss 25 (
  if /i !force! neq 0 (set force=0) else (set force=1)
  goto start
)
if %y% equ 22 if %x% gtr  31 if %x% lss 44 goto :eof
goto mouse1

:progress
cls
title %progname% - ������...
if exist %tmpregkey% del %tmpregkey% /s /q>nul
echo.>%tmpregkey%
if /i !mode! equ reg (
  if exist %regfile% del %regfile% /s /q>nul
  echo Windows Registry Editor Version 5.00>%regfile%
  echo ���ڵ�������U�����ע������ļ�%regfile%,���Ժ�...
)
if /i !mode! equ disp (
  if exist %txtfile% del %txtfile% /s /q>nul
  echo ��������U�����ע������ļ�%txtfile%,���Ժ�...
  echo ����U����ص�ע�����Ϊ��>%txtfile%
)
if /i !mode! equ del (
  if exist %logfile% del %logfile% /s /q>nul
  echo ;��־ʱ�䣺%DATE% %TIME%>%logfile%
  if exist %windir%\setupapi.log del %windir%\setupapi.log /s /q>nul
  echo ��������ע����ڵ�U��������ȷ������U�̶��Ѿ��γ�USB�ڣ�
  echo.
  echo ����λ�õ��������...
  ConsExt /event
  cls
  echo �����������Ժ�...
)
echo ��ǰ���ȣ�
for /f "eol=! tokens=*" %%z in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM" 2^>nul ^|find /i "HKEY_LOCAL_MACHINE\SYSTEM\Controlset" 2^>nul') do (
  set syspf=%%z
  echo + ����:!syspf!��
  rem USB�������洢�豸��usbstor�������ۼ�
  echo  - USB�������洢�豸��usbstor�������ۼ�
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Enum\USB"  2^>nul ^|find /i "!syspf!\Enum\USB\VID" 2^>nul') do (
    set udevid=%%a
    for /f "eol=! tokens=1,3" %%b in ('reg query "!udevid!" /s 2^>nul ^|find /i "Service" 2^>nul') do (
      set sname=%%b
      if /i !sname! equ Service (
        set stype=%%c
        if /i !stype! equ USBSTOR (
          for /f "eol=! tokens=1,3" %%d in ('reg query "!udevid!" /s  2^>nul ^|find /i "Driver" 2^>nul') do (
            set dname=%%d
            if /i !dname! equ Driver call :regkeymode "!syspf!\Control\Class\%%e"
          )
          call :regkeymode "%%a"
        )
      )
    )
  )
  if /i !force! neq 0 (
    rem ����USB�������洢�豸��usbstor�������ۼ�
    echo  - ����USB�������洢�豸��usbstor�������ۼ�
    for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\Class\{36FC9E60-C465-11CF-8056-444553540000}"  2^>nul ^|find /i "!syspf!\Control\Class\{36FC9E60-C465-11CF-8056-444553540000}\" 2^>nul') do (
      set usbdrvid=%%a
      set last4=!usbdrvid:~-4!
      set spsym=!usbdrvid:~-5,1!
      set usedflag=0
      if /i !spsym! equ \ (
        reg query "!syspf!\Enum\USB" /s 2>nul|find /i /c "{36FC9E60-C465-11CF-8056-444553540000}\!last4!" >nul 2>nul && set usedflag=1
        reg query "!syspf!\Enum\PCI" /s 2>nul|find /i /c "{36FC9E60-C465-11CF-8056-444553540000}\!last4!" >nul 2>nul && set usedflag=1
        if /i !usedflag! equ 0 call :regkeymode "%%a"
      )
    )
  )
  rem USB���̡�disk�������ۼ�
  echo  - USB���̡�disk�������ۼ�
  for /f "eol=! tokens=1,3" %%a in ('reg query "!syspf!\Enum\USBSTOR" /s 2^>nul ^|find /i "Driver" 2^>nul') do (
    set usbdname=%%a
    if /i !usbdname! equ Driver call :regkeymode "!syspf!\Control\Class\%%b"
  )
  if /i !force! neq 0 (
    rem ����USB���̡�disk�������ۼ�
    echo  - ����USB���̡�disk�������ۼ�
    for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\Class\{4D36E967-E325-11CE-BFC1-08002BE10318}"  2^>nul ^|find /i "!syspf!\Control\Class\{4D36E967-E325-11CE-BFC1-08002BE10318}\" 2^>nul') do (
      set usbdrvid=%%a
      set last4=!usbdrvid:~-4!
      set spsym=!usbdrvid:~-5,1!
      set usedflag=0
      if /i !spsym! equ \ (
        reg query "!syspf!\Enum\IDE" /s 2>nul|find /i /c "{4D36E967-E325-11CE-BFC1-08002BE10318}\!last4!" >nul 2>nul && set usedflag=1
        reg query "!syspf!\Enum\SCSI" /s 2>nul|find /i /c "{4D36E967-E325-11CE-BFC1-08002BE10318}\!last4!" >nul 2>nul && set usedflag=1
        reg query "!syspf!\Enum\USBSTOR" /s 2>nul|find /i /c "{4D36E967-E325-11CE-BFC1-08002BE10318}\!last4!" >nul 2>nul && set usedflag=1
        if /i !usedflag! equ 0 call :regkeymode "%%a"
      )
    )
  )
  rem USBSTOR�豸�ۼ�
  echo  - USBSTOR�豸�ۼ�
  call :regkeymode "!syspf!\Enum\USBSTOR"

  rem USBͨ�þ�volume�������ۼ�
  echo  - USBͨ�þ�volume�������ۼ�
  for /f "eol=! tokens=1,3" %%a in ('reg query "!syspf!\Enum\STORAGE\RemovableMedia" /s 2^>nul ^|find /i "Driver" 2^>nul') do (
    set usbvname=%%a
    if /i !usbvname! equ Driver call :regkeymode "!syspf!\Control\Class\%%b"
  )
  if /i !force! neq 0 (
    rem ����USBͨ�þ�volume�������ۼ�
    echo  - ����USBͨ�þ�volume�������ۼ�
    for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\Class\{71A27CDD-812A-11D0-BEC7-08002BE2092F}"  2^>nul ^|find /i "!syspf!\Control\Class\{71A27CDD-812A-11D0-BEC7-08002BE2092F}\" 2^>nul') do (
      set usbdrvid=%%a
      set last4=!usbdrvid:~-4!
      set spsym=!usbdrvid:~-5,1!
      set usedflag=0
      if /i !spsym! equ \ (
        reg query "!syspf!\Enum\STORAGE\RemovableMedia" /s 2>nul |find /i /c "{71A27CDD-812A-11D0-BEC7-08002BE2092F}\!last4!" >nul 2>nul && set usedflag=1
        reg query "!syspf!\Enum\STORAGE\Volume" /s 2>nul |find /i /c "{71A27CDD-812A-11D0-BEC7-08002BE2092F}\!last4!" >nul 2>nul && set usedflag=1
        if /i !usedflag! equ 0 call :regkeymode "%%a"
      )
    )
  )
  rem RemovableMedia�豸�ۼ�
  echo  - RemovableMedia�豸�ۼ�
  call :regkeymode "!syspf!\Enum\STORAGE\RemovableMedia"

  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Enum\STORAGE\Volume" 2^>nul ^|find /i "USBSTOR#" 2^>nul') do (
    set volid=%%a
    for /f "eol=! tokens=1,3" %%b in ('reg query "!volid!" /s 2^>nul ^|find /i "Driver" 2^>nul') do (
      set usbdname=%%b
      if /i !usbdname! equ Driver call :regkeymode "!syspf!\Control\Class\%%c"
    )
    call :regkeymode "%%a"
  )
  rem Deviceclasses�豸�ۼ�
  echo  - Deviceclasses�豸�ۼ�
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{53f56307-b6bf-11d0-94f2-00a0c91efb8b}" 2^>nul ^|find /i "USBSTOR#" 2^>nul') do (
    call :regkeymode "%%a"
  )
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{53f56308-b6bf-11d0-94f2-00a0c91efb8b}" 2^>nul ^|find /i "USBSTOR#" 2^>nul') do (
    call :regkeymode "%%a"
  )
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{53f5630a-b6bf-11d0-94f2-00a0c91efb8b}" 2^>nul ^|find /i "USBSTOR#" 2^>nul') do (
    call :regkeymode "%%a"
  )
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}" 2^>nul ^|find /i "USBSTOR#" 2^>nul') do (
    call :regkeymode "%%a"
  )

  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{53f5630a-b6bf-11d0-94f2-00a0c91efb8b}" 2^>nul ^|find /i "STORAGE#RemovableMedia#" 2^>nul') do (
    call :regkeymode "%%a"
  )
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}" 2^>nul ^|find /i "STORAGE#RemovableMedia#" 2^>nul') do (
    call :regkeymode "%%a"
  )

  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{a5dcbf10-6530-11d2-901f-00c04fb951ed}" 2^>nul ^|find /i "USB#" 2^>nul') do (
    set udcid=%%a
    for /f "eol=! tokens=1,3" %%b in ('reg query "!udcid!" /s 2^>nul ^|find /i "DeviceInstance" 2^>nul') do (
      set diname=%%b
      if /i diname equ DeviceInstance (
        set udenum=!syspf!\Enum\%%c
        for /f "eol=! tokens=1,3" %%d in ('reg query "!udenum!" /s  2^>nul ^|find /i "Service" 2^>nul') do (
          set sname=%%d
          if /i !sname! equ Service (
            set stype=%%e
            if /i !stype! equ USBSTOR call :regkeymode "%%a"
          )
        )
      )
    )
  )
  rem UMB�豸��ۼ�
  echo  - UMB�豸��ۼ�
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Enum\WpdBusEnumRoot\UMB" 2^>nul ^|find /i "USBSTOR#" 2^>nul') do (
    set udevid=%%a
    for /f "eol=! tokens=1,3" %%b in ('reg query "!udevid!" /s  2^>nul ^|find /i "Driver" 2^>nul') do (
      set dname=%%b
      if /i !dname! equ Driver call :regkeymode "!syspf!\Control\Class\%%c"
    )
    call :regkeymode "%%a"
  )
  if /i !force! neq 0 (
    rem ����UMB�豸�������ۼ�
    echo  - ����UMB�豸�������ۼ�
    for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\Class\{EEC5AD98-8080-425F-922A-DABF3DE3F69A}"  2^>nul ^|find /i "!syspf!\Control\Class\{EEC5AD98-8080-425F-922A-DABF3DE3F69A}\" 2^>nul') do (
      set usbdrvid=%%a
      set last4=!usbdrvid:~-4!
      set spsym=!usbdrvid:~-5,1!
      set usedflag=0
      if /i !spsym! equ \ (
        reg query "!syspf!\Enum\WpdBusEnumRoot\UMB" /s 2>nul |find /i /c "{EEC5AD98-8080-425F-922A-DABF3DE3F69A}\!last4!" >nul 2>nul && set usedflag=1
        if /i !usedflag! equ 0 call :regkeymode "%%a"
      )
    )
  )
  
  rem USBSTOR����ۼ�
  echo  - USBSTOR����ۼ�
  call :regkeymode "!syspf!\Services\USBSTOR\Enum"
  rem UsbFlags�ۼ�
  echo  - UsbFlags�ۼ�
  call :regkeymode "!syspf!\Control\UsbFlags"
)
echo + �����û���
rem ���ص㡰MountPoints���ۼ�
echo  - ���ص㡰MountPoints���ۼ�
for /f "eol=! tokens=1,3" %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices" 2^>nul') do (
  set findf=0
  set mnreg=%%b
  set first8=!mnreg:~0,8!
  set first64=!mnreg:~0,64!
  if /i !first64! equ 5C003F003F005C00530054004F0052004100470045002300520065006D006F00 set findf=1
  if /i !first64! equ 5C003F003F005C00550053004200530054004F00520023004300640052006F00 set findf=1
  if /i !first8! equ 5f003f00 set findf=1
  if /i !findf! equ 1 (
    set udmn=%%a
    if /i !udmn:~-1! equ : (
      set udmn=!udmn:~-2,1!
    ) else (
      set udmn=!udmn:~-38!
    )
    call :regvalmode "HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices" "%%a"
    for /f "eol=! tokens=*" %%c in ('reg query "HKEY_USERS" 2^>nul ^|find /i /v "_Classes" 2^>nul') do (
      call :regkeymode "%%c\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\!udmn!"
    )
  )
)
:done
title %progname% - ���
if /i !mode! equ reg (
  echo ����%regfile%��ϣ�
  echo TIPS�������ʹ�ü��±������Ϊ���ܽ��䱣�浽����λ��
  start notepad %regfile%
)
if /i !mode! equ disp (
  echo ����%txtfile%��ϣ�
  echo TIPS�������ʹ�ü��±������Ϊ���ܽ��䱣�浽����λ��
  start notepad %txtfile%
)
if /i !mode! equ del (
  echo ������ϣ�
  echo ��������־...
  start notepad %logfile%
) 
echo ����λ�õ����귵�����˵�...
ConsExt /event
goto start
goto :eof

:regkeymode
setlocal
set regkeymode=%1
rem type %tmpregkey% | find /i !regkeymode! >nul 2>nul
rem if /i !errorlevel! neq 0 (
  reg query !regkeymode! >nul 2>nul
  if /i !errorlevel! equ 0 (
    if /i !mode! equ disp echo !regkeymode!��>>%txtfile%
    if /i !mode! equ del (
      SetACL -on !regkeymode! %RegOwnr% >nul 2>nul
      SetACL -on !regkeymode! %RegFull% >nul 2>nul
      reg delete !regkeymode! /f >nul 2>nul
      if /i !errorlevel! neq 0 (
        for /f "eol=! tokens=*" %%t in ('reg query !regkeymode!  2^>nul ^|find /i "\" 2^>nul') do (
          if /i "%%t" neq !regkeymode! call :regkeymode "%%t"
        )
        SetACL -on !regkeymode! %RegOwnr% >nul 2>nul
        SetACL -on !regkeymode! %RegFull% >nul 2>nul
        reg delete !regkeymode! /f >nul 2>nul
        if /i !errorlevel! neq 0 (
          echo ����!regkeymode!��ʧ�ܣ�����ע������ֶ�����
          echo ʧ�ܣ�!regkeymode!>>%logfile%
        ) else (echo �ɹ���!regkeymode!>>%logfile%)
      ) else (echo �ɹ���!regkeymode!>>%logfile%)
    )
    if /i !mode! equ reg (
      SetACL -on !regkeymode! %RegOwnr% >nul 2>nul
      SetACL -on !regkeymode! %RegFull% >nul 2>nul
      if exist %tmpregfile% del %tmpregfile% /s /q >nul 2>nul
      reg export !regkeymode! %tmpregfile% >nul 2>nul && type %tmpregfile% 2>nul |find /i /v "Windows Registry Editor Version 5.00" >>%regfile% 2>nul
    )
rem     echo !regkeymode!>>%tmpregkey%
  )
rem )
endlocal
goto :eof

:regvalmode
setlocal
set regvalmodekey=%1
set regvalmode=%2
reg query !regvalmodekey! /v !regvalmode! >nul 2>nul
if /i !errorlevel! equ 0 (
  if /i !mode! equ disp echo !regvalmodekey!���µ�!regvalmode!��ֵ>>%txtfile%
  if /i !mode! equ del (
    SetACL -on !regvalmodekey! %RegOwnr% >nul 2>nul
    SetACL -on !regvalmodekey! %RegFull% >nul 2>nul
    reg delete !regvalmodekey! /v !regvalmode! /f >nul 2>nul
    if /i !errorlevel! neq 0 (
      echo ����!regvalmodekey!���µ�!regvalmode!��ֵʧ�ܣ�����ע������ֶ�����
      echo ʧ�ܣ�!regvalmodekey!���µ�!regvalmode!��ֵ>>%logfile%
    ) else (echo �ɹ���!regvalmodekey!���µ�!regvalmode!��ֵ>>%logfile%)
  )
  if /i !mode! equ reg (
    type %tmpregkey% | find /i !regvalmodekey! >nul 2>nul
    if /i !errorlevel! neq 0 (
      SetACL -on !regvalmodekey! %RegOwnr% >nul 2>nul
      SetACL -on !regvalmodekey! %RegFull% >nul 2>nul
      if exist %tmpregfile% del %tmpregfile% /s /q >nul 2>nul
      reg export !regvalmodekey! %tmpregfile% >nul 2>nul && type %tmpregfile% 2>nul |find /i /v "Windows Registry Editor Version 5.00" >>%regfile% 2>nul
      echo !regvalmodekey!>>%tmpregkey%
    )
  )
)
endlocal
goto :eof