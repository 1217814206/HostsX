// =========ADBlock��Ϣ=========
// @��д��           ���·���   o(��_��)o 
// @������ʱ�䣺   2011��8��17��
// @�汾��           ���԰�
// @��лTW��̳�ĸ�λ����ӻԾ�����Ĺ��˹����Bug����лTW��̳���а����ļ���֧�֡�����ʹ�ù����������ʣ��ɵ�TW��̳�����˰�鷴����
// =========ADBlock��Ϣ==========


//��ʼ����
function FindProxyForURL(url, host){
    url = url.toLowerCase();

    for (i in gz_blacklist) { if (gz_blacklist[i].test(url)){return whitelist_check(url);};};                         //���������������
    for (i in gt_blacklist) {	if (shExpMatch(url,gt_blacklist[i].toLowerCase())){return whitelist_check(url);};};     //������ͨ���������

    //�������������
    if (black_ad.test(url)){return white_zt_check(url, white_z_ad, white_t_ad);};                     //����black_ad
    if (shExpMatch(url,black_union.toLowerCase())){return white_t_check(url, white_t_union);};        //����black_union
    if (black_js.test(url)){return white_t_check(url, white_t_js);};                                  //����black_js
    for (i in black_tvad) { if (black_tvad[i].test(url)){return white_t_check(url,white_t_tvad);};};  //����black_tvad
    
    return ALLOW;
};

var BLOCK="PROXY 0.0.0.0";   //���ι��Ĵ���
var ALLOW= "DIRECT";         //����

//�������������
var gz_blacklist = new Array(
/51\.la|51yes|cnzz\.com|linezing\.com|\/tongji\.js|google-analytics\.com\/ga\.js/i,
/\.ct10000\.com[\s\S]*?\/push\/|\d{2,3}\.\d{2,3}\.\d{2,3}\.\d{2,3}[^\/]\/openv\d\.js/i,
/(?:cbjs|spcode|eiv)\.baidu|\.alimama\.cn\/s?inf\.js|clickeye|\.allyes\.|vogate|icast|guangg|\/[\w]\.91wan\.com|zdy\.cc|egooad|qqpflm|\.p4p\.|ok8848|csyouxi|pp9a|9dcpm|71aiyou|4001688|45511\.com|pee\.cn/i,
/\/ghost\d[^\.]*?\.gif|heima8|\.myad\.cn|keyrun|un\.so|un\.265|7click|\/cpc\/|chinaih|778669|gamediad|cpm9v|yoyi|adsame|keydot|imrworldwide|2bj\.cc|na7\.cc|sharele|61ads|2bj\.cc|ejoina\.com/i,
/yigao|busjs\.vodone|\/cpro\/|1133\.cc|leomediachina|37cs|netgy|wauee|qianming|duilian|100fenlm|8le8le|manyan|qqw36|9vcpm|onetad|naqigs|58win|66789\.com|popjs|yiqiwin|9vcpc|ifocus|kfwan/i,
/heroclick\.cn|33hy\.com|redu\.com|youday|\.84232\.com|code\.tjlove8\.com|\.37see\.com|\.5622\.cn|\.qling\.com|198game|ulink\.cc|155game|star8\.net|zedo\.com|xi666\.com|qiyou\.com|88210212\.com/i,
/img\.cnbeta\.com\/\w+\d{3}\.[f-p]{3}|dcads|qqnews|cnmovie|market\.duowan\.com|bbs\.17173\.com\/x\/|91now\.com\/down\/other\/js\/A_|newhuagg\/[\s\S]*?(?:newhua_|_bannar)[\s\S]*?\.js/i,
/\/ivy[\/\.]|pconline\.com\.cn\/(?:images\/lmt\/area_lmt|itbbs09\/js\/itbbs09_wd)\.js|piaodown\.com\/other\/js\/|img\d\.126\.net\/|d\d\.sina\.com\.cn/i,
/115\.com\/static\/tjj\/|806\.tianya\.cn|img\.jb51\.net\/imgby\/|966\.com\/js\/msn\.js|pic\.zol-img\.com\.cn|\/g\.hsw\.cn/i,
/tvbkt\.cn\/js\/tvb\/hd\d\.js|\.piaohua\.com\/[\s\S]*?_nei_|ifeng\.com\/tres\/(?:recommend|ifeng\/game)\/|by\.dm5\.com\/jsv2\/|cj\.qidian\.com\/Picture\//i,
//������վ
/xiazaiba\.com\/js\/[\s\S]*?(?:_center|down_advert|detail_|img_text)|\/orsoon\/[\s\S]*?\.js/i,
//��ľ������
/\/a*?\d\.exe/i);

//����ͨ���������
var gt_blacklist = new Array(
"*.crsky.com/ggao/*"
);

//�������������
var gz_whitelist =new Array(
/\.(?:taobao|tmall|tbcdn|alipay|paipai|360buy|newegg|amazon|dangdang|pceggs|unionpay)\.|qzone|mail\./i);

//����ͨ���������
var gt_whitelist =new Array(
"*.css",
"*crsky.com/ggao/index_a.js",
"*djkk.com/ak/*",
"*.house365.com/*.html",
"*afp.120ask.*",
"*img*.126.net/caipiao/*");

//����ڰ�����
var black_tvad = new Array(
/images\.sohu\.com\/|\.atm\.youku\.com\/|asc86|biz\d|acs\.(?:56|agent)|888\.ku6|a\.cntv\.cn|cntv\.cn\/adplayer\/|\/adpolestar\//i,
/\.m1905.com\/uploadfile\/[\s\S]*?\.swf|afp\.qiyi\.com\/|86file\.megajoy|megajoy\.com\/toolbar\//i,
/js\.tudouui\.com\/js\/fn\/minibar_\d\.js|tdcm\.tudou\.com|v2\.tudou\.com\/tdcm\//i);
var white_t_tvad = new Array(
"*.youku.com/so_*",
"*6.cn/csjs10/*.js*",
"*images.sohu.com/bill/s20*/comm/index.html" //�޸��Ѻ������۱������ 
);

var black_js =/\/\/[^\?\=]*?(?:[^egop](?:popup|tan|float|ads?)([^a-z][^\.\?\&\=%]*?)?|\/(?:gg|guanggao|ggao)\/[\s\S]*?|\/qq\d?|\/[a-z]|[^\d]\d{2,3}[_x\-]\d{2,3})\.js$/i;
var white_t_js = new Array(
"*.ct10000.com/*.popup.js*",
"*static.youku.com/*/js/popup.js*",
"*.sse.com.cn/*/sse_popup.js*",
"*.qq.com/js/*",
"*.ik123.com/js/*",
"*tv.sohu.com/upload/jq_plugin/*",  //�޸��Ѻ���Ƶ������ҳ�治����ʾ�缯�б�
"*msdn.itellyou.cn/*");

var black_ad = /[\/\_\.\?\&\-]ads?[\/\_\.\d\-]|[^eop]ads?(?:id|puba|top|flash|click|client|code|file|frame|view|img|text|info|page|sence|show|serv|ertimg|detail)/i;
var white_z_ad= new Array(
/[^g-z\.\/\=\&\#\?\%]{9}ad(?![g-z])|[^g-z]ad[^g-z\.\/\=\&\#\?\%]{9}/i);
var white_t_ad = new Array(
"*.xunlei.com/video/js/play_ad.js*",
"*js.player.cntv.cn/*_ad.js*",
"*.xitek.com/*/adclick.php*",
"*jxad.jx163.com/ad/jxfc/*.html",
"*.m1905.com/*",
"*flight.qunar.com/site/config/OTA_AD_CONFIG.js*",
"*.3366.com/component/*adid*");

var black_union = "*uinion*";
var white_t_union = new Array(
"*qilehui.com*union.js",
"*.qunar.com/*scripts/union/*",
"*union.bokecc.com/*",
"*communion.gamebar.com*",
"*.bluemov.com/e/DownSys/DownSoft*union*",
"*.tianya.cn/publicforum/*union.shtml*",
"*.10086.cn*union*",
"*bbs.voc.com.cn/*/union.js",
"*union.mapbar.com/apis/*");


//�����ð�����
function whitelist_check(url){
    for (i in gz_whitelist) { if (gz_whitelist[i].test(url)){return ALLOW;};};
    for (i in gt_whitelist) {	if (shExpMatch(url,gt_whitelist[i].toLowerCase())){return ALLOW;};};
    return BLOCK;
};
//�������������(�����ͨ���)
function white_zt_check(url,white_z,white_t){
    for (i in gz_whitelist) { if (gz_whitelist[i].test(url)){return ALLOW;};};
    for (i in gt_whitelist) {	if (shExpMatch(url,gt_whitelist[i].toLowerCase())){return ALLOW;};};
    for (i in white_z) { if (white_z[i].test(url)){return ALLOW;};};
    for (i in white_t) {	if (shExpMatch(url,white_t[i].toLowerCase())){return ALLOW;};};
    return BLOCK;
};
//�������������(����)
function white_z_check(url,white_z){
    for (i in gz_whitelist) { if (gz_whitelist[i].test(url)){return ALLOW;};};
    for (i in gt_whitelist) {	if (shExpMatch(url,gt_whitelist[i].toLowerCase())){return ALLOW;};};
    for (i in white_z) { if (white_z[i].test(url)){return ALLOW;};};
    return BLOCK;
};
//�������������(ͨ���)
function white_t_check(url,white_t){
    for (i in gz_whitelist) { if (gz_whitelist[i].test(url)){return ALLOW;};};
    for (i in gt_whitelist) {	if (shExpMatch(url,gt_whitelist[i].toLowerCase())){return ALLOW;};};
    for (i in white_t) {	if (shExpMatch(url,white_t[i].toLowerCase())){return ALLOW;};};
    return BLOCK;
};