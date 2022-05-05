#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$_ = "abracadabra"; #検索対象文字列を$_に代入
$count = s/ab/AB/;  #文字列置換
print $count;       #置換数出力。結果：1
print "\n";
print $_;           #文字列出力。結果：ABracadabra
print "\n";
$count = s/a/A/g;   #文字列置換。g修飾子ですべて置換
print $count;       #置換数出力。結果：4
print "\n";
print $_;           #文字列出力。結果：ABrAcAdAbrA
print "\n";
$count = s/a/^/ig;  #文字列置換。i修飾子で大文字小文字無視
print $count;       #置換数出力。結果：5
print "\n";
print $_;           #文字列出力。結果：^Br^c^d^br^
print "</PRE></BODY></HTML>";
