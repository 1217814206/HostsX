@echo off
set ver=1.05
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
pushd %~dp0
if not exist wget.exe goto echo û���ҵ�Wget.exe& choice /t 2 /d y /n >nul & goto exit
Tasklist|Find /i "opera.exe">nul&mshta vbscript:msgbox("�����˳�Opera��!",64,"SimpleU+")(window.close)&Pause
echo �����������ݣ����Ժ�... ...
del operaprefs_default.ini locale\en\license.txt locale\zh-cn\bookmarks.adr locale\zh-cn\standard_speeddial.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/operaprefs_default.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/license.txt
wget http://hostsx.googlecode.com/svn/trunk/Opera/bookmarks.adr
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_speeddial.ini
move license.txt locale\en
move bookmarks.adr locale\zh-cn
move standard_speeddial.ini locale\zh-cn
echo Ĭ�������Ѹ��£�
cd profile\script
del Super_preloader.db
wget http://Hostsx.googlecode.com/svn/trunk/Opera/Super_preloader.db.js
echo UserJs�����Ѹ��£�
cd ..
del /f /q autoupdate_response.xml download.dat global_history.dat opthumb.dat search_field_history.dat tasks.xml vlink4.dat opuntrust.dat optrust.dat optrb.dat typed_history.xml upgrade.log
rd /s /q application_cache cache dictionaries icons opcache pstorage temporary_downloads vps webserver
echo ʹ�úۼ��������!
del override.ini search.ini urlfilter.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/override.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/search.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/urlfilter.ini
del keyboard\standard_keyboard.ini mouse\standard_mouse.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_keyboard.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_mouse.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_menu.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_toolbar.ini
md mouse keyboard menu toolbar
move standard_keyboard.ini keyboard\
move standard_menu.ini menu\
move standard_mouse.ini mouse\
move standard_toolbar.ini toolbar\
cd ..
echo Profiles�����Ѹ���!
cd profile\styles\user
del BBS.css Custom.css OperaU.css
wget http://hostsx.googlecode.com/svn/trunk/Opera/BBS.css
wget http://hostsx.googlecode.com/svn/trunk/Opera/Custom.css
wget http://hostsx.googlecode.com/svn/trunk/Opera/OperaU.css
echo CSS�����Ѹ���!
mshta vbscript:msgbox("�����ļ���������״̬��",64,"SimpleU+")(window.close) & goto exit
