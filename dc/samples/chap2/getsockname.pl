#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Socket;                               #Socketモジュール読み込み
$proto = getprotobyname'tcp';             #tcpプロトコルを取得
socket SOCKET,PF_INET,SOCK_STREAM,$proto; #ソケット作成
$ipaddr = inet_aton("localhost");         #ホスト名をIPアドレスに変換
$paddr = pack_sockaddr_in 80,$ipaddr ;    #localhost:80に接続
connect SOCKET,$paddr;                    #HTTPサーバが起動していれば接続成功
$addr = getsockname SOCKET;               #接続先アドレス取得
($port,$iaddr) = unpack_sockaddr_in $addr;#ポートとアドレスに分解
print $port;                              #自分のポート番号を出力。結果：3807
print "</PRE></BODY></HTML>";
