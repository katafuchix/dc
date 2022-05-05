#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print int 2.45;                   #結果：2
print "\n";
print &ceil(1.5);                 #切り上げ。結果：2
print "\n";
print &ceil(2.0);                 #切り上げ。結果：2
print "\n";
print &halfadjust(1.5);           #四捨五入。結果：2
print "\n";
print &halfadjust(1.4);           #四捨五入。結果：1
print "\n";
print &halfadjust(2.0);           #四捨五入。結果：2
sub ceil { int($_[0]) == $_[0] ? $_[0] : int($_[0]) + 1 } 
sub halfadjust { int($_[0] + 0.5) == $_[0] + 1.0 ? int($_[0]) : int($_[0] + 0.5)} 
print "</PRE></BODY></HTML>";
