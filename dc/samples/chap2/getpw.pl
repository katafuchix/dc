#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@info = getpwnam 0;      #ユーザID=0のユーザ情報取得
print $info[0];          #ユーザ名出力。結果：root
print "\n";
print $info[7];          #ホームディレクトリ出力。結果：/root
print "\n";
print $info[8];          #シェル出力。結果：/bin/bash
print "\n";
@info = getpwnam "doi";  #ユーザdoiのユーザ情報取得
print $info[0];          #ユーザ名出力。結果：doi
print "\n";
print $info[7];          #ホームディレクトリ出力。結果：/home/doi
print "\n";
print $info[8];          #シェル出力。結果：/bin/bash
print "</PRE></BODY></HTML>";
