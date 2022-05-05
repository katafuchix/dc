#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Socket;                                       #Socketモジュール読み込み
socket SOCKET,PF_INET,SOCK_STREAM,getprotobyname'tcp';
connect SOCKET,pack_sockaddr_in 80,inet_aton"localhost"; #HTTPサーバに接続
send SOCKET,"GET /\n.",0;          #GETメッセージ送信
recv SOCKET,$str,1000,0 or die;    #HTTPサーバから受信
print $str;                        #結果：HTTP/1.1 200 OK...
print "</PRE></BODY></HTML>";
