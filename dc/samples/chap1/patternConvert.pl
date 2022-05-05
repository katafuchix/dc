#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$_ = "abcdefg"; #変換対象文字列
tr/c-f/ /s;     #c-fを （スペース）に変換。s修飾子で重複は1つにまとめる
print;          #結果：ab g
print "\n";
$_ = "abcdefg"; #変換対象文字列
y/a-c//d;       #a-cを変換。d修飾子で対応する文字が無い文字は削除
print;          #結果：defg
print "</PRE></BODY></HTML>";
