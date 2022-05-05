#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$pi = 3.14159265;                 #πの値
print sin $pi / 6;                #sin30° 結果：0.4999...
print "\n";
print cos $pi / 3;                #cos60° 結果：0.5000...
print "\n";
print tan($pi / 4);               #tan45° 結果：0.9999...
sub tan { sin($_[0]) / cos($_[0])}#タンジェント（正接）サブルーチン
print "</PRE></BODY></HTML>";
