#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$str = "ABCDEFG";
$jstr = "����������";
print length $str;   #���ʁF7
print "\n";
print length $jstr;  #���ʁF10�iShift-JIS�j
print "</PRE></BODY></HTML>";
