#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@info = getprotobyname "tcp"; #tcpのプロトコル情報取得
print $info[0];               #プロトコル名出力。結果：tcp
print "\n";
print $info[1];               #エイリアス出力。結果：TCP
print "\n";
print $info[2];               #プロトコル番号出力。結果：6
print "\n";
@info = getprotobynumber 17;  #プロトコル番号17のプロトコル情報取得
print $info[0];               #プロトコル名出力。結果：udp
print "\n";
print $info[1];               #エイリアス出力。結果：UDP
print "\n";
print $info[2];               #プロトコル番号出力。結果：17
print "</PRE></BODY></HTML>";
