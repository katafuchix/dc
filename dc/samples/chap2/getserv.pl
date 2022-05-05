#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@info = getservbyname "http","tcp"; #httpのサービス情報取得
print $info[0];                     #サービス名出力。結果：http
print "\n";
print $info[1];                     #エイリアス出力。結果：www
print "\n";
print $info[2];                     #ポート番号出力。結果：80
print "\n";
@info = getservbyport 21,"tcp";     #ポート番号21のサービス情報取得
print $info[0];                     #サービス名出力。結果：ftp
print "\n";
print $info[1];                     #エイリアス出力。結果：fsp
print "\n";
print $info[2];                     #ポート番号出力。結果：21
print "</PRE></BODY></HTML>";
