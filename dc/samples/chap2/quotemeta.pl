#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$str = "ABC.DEF-G|";
print quotemeta $str;  #���ʁFABC\.DEF\-G\|
print "</PRE></BODY></HTML>";
