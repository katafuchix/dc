#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
setpwent;                #ユーザ情報取得開始
while(@info = getpwent){ #ユーザ情報取得
  print $info[0];        #ユーザ名を出力。結果：root doi ...
  print "\n";
  print $info[7];        #ホームディレクトリを出力。結果：/root /home/doi...
  print "\n";
  print $info[8];        #シェルを出力。結果：/bin/sh /bin/bash...
  print "\n";
}       
endpwent;                #ユーザ情報取得終了
print "</PRE></BODY></HTML>";
