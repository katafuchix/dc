#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@info = gethostbyname "www.yahoo.co.jp"; #名前からホスト情報取得
print $info[0];                          #ホスト名出力。結果：www.yahoo.co.jp
print "\n";
$addr = pack('C4',127,0,0,1);            #アドレスを4バイトにパック
@info = gethostbyaddr $addr,2;           #アドレスからホスト情報取得
print $info[0];                          #ホスト出力。結果：fedora4
print "\n";
print $info[2];                          #アドレスタイプ出力。結果：2
print "</PRE></BODY></HTML>";
