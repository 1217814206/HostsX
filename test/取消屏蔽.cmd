@echo off
set file=%windir%\system32\drivers\etc\hosts
set size=732

copy /Y old\hosts %windir%\system32\drivers\etc

for /f "tokens=3 delims= " %%a in ('dir /-c %file% ^| find "1 ���ļ�"') do (  
                      echo.
                      if %%a equ %size% 	(
		           pause>nul|echo  ��ȡ�����Σ�������˳� .....
		           exit
		       )
	)
      pause>nul|echo  �޷�ȡ�����Σ�������˳� .....