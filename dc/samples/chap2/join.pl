#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my @strings = ("Blue","Red","Green");
print join ",",@strings; #区切り文字,で連結。結果：Blue,Red,Green
print "</PRE></BODY></HTML>";
