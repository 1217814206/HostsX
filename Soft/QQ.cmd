@ECHO OFF

ECHO ��ر��������е�QQ��TM�������������
PAUSE 1>NUL 2>NUL
taskkill /im qq.exe
taskkill /im tm.exe

ECHO ����д��HOSTS�ļ��������ɱ�����������������д��
ECHO 0.0.0.0	fodder.qq.com >>%SYSTEMROOT%\SYSTEM32\DRIVERS\ETC\HOSTS
ECHO 0.0.0.0	adshmct.qq.com >>%SYSTEMROOT%\SYSTEM32\DRIVERS\ETC\HOSTS
ECHO 0.0.0.0	hm.l.qq.com >>%SYSTEMROOT%\SYSTEM32\DRIVERS\ETC\HOSTS
ECHO 0.0.0.0	adshmmsg.qq.com >>%SYSTEMROOT%\SYSTEM32\DRIVERS\ETC\HOSTS

ECHO ����ɾ�����ػ��桭��
cd "%AppData%\Tencent\QQ\Misc"
for /d %%i in (com.tencent.advertisement*) do rd "%%i" /s /q
cd "%AppData%\Tencent\Users\"
del misc.db /s /q

ECHO.
ECHO �Ѿ��㶨�ˣ� o(��_��)o
ECHO by ľ��(2011.05.25)
PAUSE 1>NUL 2>NUL
