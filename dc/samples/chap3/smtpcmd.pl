#!/usr/bin/perl
use Net::SMTP;
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$smtp = Net::SMTP->new('mailserver'); #mailserverサーバへ接続
print $smtp->banner(); #バナーメッセージ取得。結果：mailserver ESMTP
print $smtp->domain(); #ドメイン名取得。結果：mailserver
$smtp->reset();        #リセット
$smtp->quit;           #SMTP終了
print "</PRE></BODY></HTML>";
