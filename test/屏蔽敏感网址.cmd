@echo off
set file=%windir%\system32\drivers\etc\hosts
set size=15866

rem ����IE�����ӵ�ַ��������
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v AutoSearch /t reg_dword /d 00000000 /f
copy /y hosts %windir%\system32\drivers\etc

rem dir /-c %file%

for /f "tokens=3 delims= " %%a in ('dir /-c %file% ^| find "1 ���ļ�"') do (  
                      echo.
                      if %%a equ %size% 	(
		           pause>nul|echo  �ļ���С�������γɹ���������˳� .....
		           exit
		       )
	)
      pause>nul|echo  ����ʧ�ܣ�������˳� .....