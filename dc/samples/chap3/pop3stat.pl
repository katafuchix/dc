#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Net::POP3;                         #Net::POP3モジュール読み込み
$pop3 = Net::POP3->new('mailserver');  #mailserverサーバに接続
$pop3->login("username","password");   #ユーザ名user、パスワードpassで認証
($num,$size) = $pop3->popstat();       #メッセージ数、サイズ取得
print "Message : $num , Size: $size\n";
$list = $pop3->list();                 #メッセージ一覧取得
$uidl = $pop3->uidl();                 #ユニークID取得
foreach $i(keys %$list){               #キーのメッセージ番号を取得
  print "$i : $list->{$i} : $uidl->{$i}\n";
  #メッセージ番号、サイズ、ユニークIDを出力
}
$pop3->quit;
print "</PRE></BODY></HTML>";
