#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@info = getnetbyname "loopback"; #loopbackネットワーク情報取得
print $info[0];                  #ネットワーク名出力。結果：loopback
print "\n";
$addr = pack('C4',127,0,0,1);    #アドレスを4バイトにパック
@info = getnetbyaddr $addr,2;    #アドレスからネットワーク情報取得
print $info[0];                  #ネットワーク名。結果：loopback
print "</PRE></BODY></HTML>";
