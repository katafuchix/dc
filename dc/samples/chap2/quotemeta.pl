#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$str = "ABC.DEF-G|";
print quotemeta $str;  #Œ‹‰ÊFABC\.DEF\-G\|
print "</PRE></BODY></HTML>";
