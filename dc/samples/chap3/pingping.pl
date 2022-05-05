#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Net::Ping;                    #Net::POP3モジュール読み込み
$ping = Net::Ping->new("tcp",10); #TCPプロトコルでタイムアウト秒数10秒指定
print $ping->ping("localhost");   #ping送信。結果：1 1 127.0.0.1
print "\n";
print pingecho("localhost");      #ping送信。結果：1 1 127.0.0.1
$ping->close();                   #Net::Pingインスタンス破棄
print "</PRE></BODY></HTML>";
