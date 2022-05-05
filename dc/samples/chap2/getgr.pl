#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@info = getgrnam "root"; #rootのグループ情報取得
print $info[0];          #グループ名出力。結果：root
print "\n";
print $info[2];          #グループID出力。結果：0
print "\n";
print $info[3];          #メンバ出力。結果：root
print "\n";
@info = getgrgid 1;      #グループID=1のグループ情報取得
print $info[0];          #グループ名出力。結果：bin
print "\n";
print $info[2];          #グループID出力。結果：1
print "\n";
print $info[3];          #メンバ出力。結果：root bin daemon
print "</PRE></BODY></HTML>";
