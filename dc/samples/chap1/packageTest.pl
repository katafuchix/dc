#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
require sample;         #sampleパッケージをロード
print &sample::sample1; #sampleパッケージのsample1サブルーチンを呼び出し
#結果：sample::sample1
print "</PRE></BODY></HTML>";
