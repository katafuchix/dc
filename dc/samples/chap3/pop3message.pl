#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Net::POP3;                         #Net::POP3モジュール読み込み
use Encode;                            #Encodeモジュール読み込み
$pop3 = Net::POP3->new('mailserver');  #mailserverサーバに接続
$pop3->login("username","password");   #ユーザ名user、パスワードpassで認証
$mail = $pop3->top(1,3);     #1通目のメッセージをヘッダとボディ3行まで取得
foreach(@$mail){                       #各行について
  Encode::from_to($_,"iso-2022-jp","shiftjis"); #文字コードをShift-JISに変換
  print;                               #メッセージ内容を出力
}
$pop3->delete(1);                     #1通目のメッセージを削除
$pop3->quit;
print "</PRE></BODY></HTML>";
