#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$str = "ABCDEFG";
$jstr = "あいうえお";
print length $str;   #結果：7
print "\n";
print length $jstr;  #結果：10（Shift-JIS）
print "</PRE></BODY></HTML>";
