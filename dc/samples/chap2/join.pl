#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my @strings = ("Blue","Red","Green");
print join ",",@strings; #��؂蕶��,�ŘA���B���ʁFBlue,Red,Green
print "</PRE></BODY></HTML>";
