DNS ת���� V2.3

�˰汾�󲿷ֵ�����ͨ�������ļ����� (��������ļ�)�������������������в�����

dnsforwarder.exe [����]
 [����] �����ִ�Сд��
  -f <FILE>  ָ�������ļ���
  -q         ����ģʽ������ʾ�κ���Ϣ��
  -e         ֻ��ʾ������Ϣ��
  -d         ��̨ģʽ��
  -h         ��ʾ�˰�����

ʹ�÷�����
�򿪴˳���󣬽�DNS����Ϊ127.0.0.1

�����ļ����� XML ��ʽ������ͨ���ı��༭�����ɡ�


http://micasmica.blogspot.com/2011/08/dns.html
http://micasmica.blogspot.tw/2011/08/dns.html

��������ʾ����ִ�� ��nslookup www.google.com 127.0.0.1�����Կ���Ч����
 
#  cn����
ExcludedDomain .cn,*cdn*
#  �ٶ�
ExcludedDomain bdstatic.com,bdimg.com,baidu.com,hao123.com,qianqian.com,skycn.com,baifubao.com,regsky.com,baidupcs.com,baidupcs.net
#  ��Ѷ
ExcludedDomain qq.com,tencent.com,gtimg.com,3366.com,qzone.com,soso.com,tdimg.com,qstatic.com,paipaiimg.com,qqmail.com,pengyou.com,idqqimg.com
#  �Ѻ�
ExcludedDomain sohu.com,sogou.com
#  ����
ExcludedDomain weibo.com
#  ����
ExcludedDomain 163.com,126.com,126.net,127.net
#  �ſ�
ExcludedDomain youku.com,youku.tv,ykimg.com
#  ����
ExcludedDomain tudou.com,tudouui.com
#  ֧����
ExcludedDomain alipay.com
#  ������Ƶ��վ
ExcludedDomain pplive.com,yinyuetai.com,letv.com,letvimg.com,ku6.com
#  �����̳�
ExcludedDomain 360buy.com,360buyimg.com,360top.com
#  ����
ExcludedDomain renren.com,renren-inc.com,xnimg.cn
#  ����
ExcludedDomain baofeng.com,baofeng.net
#  VeryCD
ExcludedDomain verycd.com,easymule.com,vcimg.com
#  Ѹ��
ExcludedDomain xunlei.com,gougou.com,kankan.com
#  360
ExcludedDomain 360safe.com,qhimg.com
#  ����
ExcludedDomain abchina.com,ccb.com,bankcomm.com,cmbchina.com,psbc.com,cebbank.com,pingan.com,ecitic.com,unionpay.com
#  ����
ExcludedDomain duotegame.com,hexun.com,xinhuanet.com,chinaunix.net,csdn.net,mop.com,fetionpic.com,kugou.com,hudong.com,kedou.com
#  Domain pointer
ExcludedDomain in-addr.arpa,ip6.arpa

��ֹ���д���ad�������Ĳ�ѯ:
DisabledDomain *ad*
DisabledDomain *material*,*tongji*,*allyes*,*analytics*,*ggao*,*counter*,*cpm*

����������Hosts����ʾ�ļ�����:
Hosts http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts
HostsDownloadPath C:\Windows\System32\drivers\etc\hosts
HostsScript type C:\Windows\System32\drivers\etc # `type' Ϊ Windows ����̨����

AppendHosts 59.151.106.253 *.operachina.com
AppendHosts 203.69.113.128 *.phobos.apple.com

��ֹ����com�����Ĳ�ѯ:
DisabledDomain .com

���ȸ���ȫ��ʹ��UDP��ѯ:
UDPServer 114.114.114.114 # ������ָ�������� UDP ������
PrimaryServer UDP
ExcludedDomain *.google.*,googleusercontent.com,googleadservices.com
