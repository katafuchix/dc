#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Net::SMTP;
use Encode;
$smtp = Net::SMTP->new('mailserver');          #mailserverサーバに接続
$smtp->mail('from@virtualdomain');             #メール送信開始
$smtp->to('to@virtualdomain2');                #宛先指定
$smtp->data();                                 #データ送信開始
$smtp->datasend("From: from\@virtualdomain\n");#メールのFromヘッダ送信
$smtp->datasend("To: to\@virtualdomain2\n");   #メールのToヘッダ送信
$subject = "こんにちは！";                     #日本語Subject
Encode::from_to($subject,"shiftjis","iso-2022-jp"); #文字コードをJISに変換
$smtp->datasend("Subject:$subject \n");        #メールのSubjectヘッダ送信
$smtp->datasend("\n");                         #メールヘッダ終了
$smtp->datasend("Hello Net::SMTP World!\n");   #メールの本文送信
$body = "お元気ですか";
Encode::from_to($body,"shiftjis","iso-2022-jp"); #文字コードをJISに変換
$smtp->datasend($body);                        #送信
$smtp->dataend();                              #データ送信終了。メール送信
$smtp->quit;                                   #SMTP終了
print "</PRE></BODY></HTML>";
