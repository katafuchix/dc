#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Socket;                               #Socketモジュール読み込み
$proto = getprotobyname'tcp';             #tcpプロトコルを取得
socket SOCKET,PF_INET,SOCK_STREAM,$proto; #ソケット作成
$ipaddr = inet_aton("localhost");         #ホスト名をIPアドレスに変換
$paddr = pack_sockaddr_in 80,$ipaddr ;    #localhost:80に接続
connect SOCKET,$paddr;                    #HTTPサーバが起動していれば接続成功
$addr = getpeername SOCKET;               #接続先アドレス取得
($port,$iaddr) = unpack_sockaddr_in $addr;#ポートとアドレスに分解
print inet_ntoa $iaddr;                   #アドレスを出力。結果：127.0.0.1
print "\n";
print $port;                              #ポート番号を出力。結果：80
print "</PRE></BODY></HTML>";
