@echo off&Title PPtvȥ������ By ��BatHome��-Hello123World
Rem ԭ��http://jl453625978.blog.163.com/blog/static/86041705201162434258723/
Set /p a=�������ϵͳ��7 or xp����
Goto %a%
Exit
:7
For /r "C:\ProgramData\PPLive\PPTV\xml" %%i in (*.xml) do (
        echo\ >"%%i"
        Attrib +r "%%i"
        )
For /r "C:\ProgramData\PPLive\PPTV\Cache\pluginad" %%i in (*.xml *.ini) do (
        Echo\ >"%%i"
        Attrib +r "%%i"
        )
Echo �ѳɹ�ȥ��pptv���
Pause>nul&exit
:xp
For /r "C:\Documents and Settings\All Users\Application Data\PPLive\PPTV\xml" %%i in (*.xml) do (
        echo\ >"%%i"
        Attrib +r "%%i"
        )
For /r "C:\Documents and Settings\All Users\Application Data\PPLive\PPTV\cache\pluginad" %%i in (*.xml *.ini) do (
        Echo\ >"%%i"
        Attrib +r "%%i"
        )
Echo �ѳɹ�ȥ��pptv���
pause>nul