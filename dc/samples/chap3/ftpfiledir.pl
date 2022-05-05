#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Net::FTP;                     #Net::FTPモジュール読み込み
$ftp = Net::FTP->new("ftpserver");#ftpserverサーバに接続
$ftp->login();                    #anonymousログイン
$ftp->port();                     #ポート番号自動でデータコネクション接続
$ftp->mkdir("sub1/sub2",1);       #sub1/sub2ディレクトリを作成
$ftp->cwd("sub1/sub2");           #sub1/sub2ディレクトリへ移動
print $ftp->pwd();                #カレントディレクトリ表示。結果：/sub1/sub2
$ftp->quit();                     #接続終了
print "</PRE></BODY></HTML>";
