#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Net::FTP;                     #Net::FTPモジュール読み込み
$ftp = Net::FTP->new("ftpserver");#ftpserverサーバに接続
$ftp->login();                    #anonymousログイン
$ftp->port();                     #ポート番号自動でデータコネクション接続
print $ftp->ls();                 #ファイルリストを取得
#結果：sample.txt
print $ftp->dir();                #ファイルリストを長い形式で取得
#結果：02-10-06  05:38PM                    4 sample.txt
$ftp->quit();                       #接続終了
print "</PRE></BODY></HTML>";
