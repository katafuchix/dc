#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my @strings = ("Blue","Red","Green");
print join ",",@strings; #‹æØ‚è•¶š,‚Å˜AŒ‹BŒ‹‰ÊFBlue,Red,Green
print "</PRE></BODY></HTML>";
