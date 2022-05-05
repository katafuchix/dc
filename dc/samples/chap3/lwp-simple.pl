#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use LWP::Simple;
print head("http://www.yahoo.co.jp/"); #HEADリクエストでヘッダ情報を取得。
#結果：text/html;charset=euc-jp
getprint("http://www.yahoo.co.jp/"); #GETリクエスト結果を標準出力
#結果：<html><head>...
print "</PRE></BODY></HTML>";
