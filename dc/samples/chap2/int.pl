#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print int 2.45;                   #���ʁF2
print "\n";
print &ceil(1.5);                 #�؂�グ�B���ʁF2
print "\n";
print &ceil(2.0);                 #�؂�グ�B���ʁF2
print "\n";
print &halfadjust(1.5);           #�l�̌ܓ��B���ʁF2
print "\n";
print &halfadjust(1.4);           #�l�̌ܓ��B���ʁF1
print "\n";
print &halfadjust(2.0);           #�l�̌ܓ��B���ʁF2
sub ceil { int($_[0]) == $_[0] ? $_[0] : int($_[0]) + 1 } 
sub halfadjust { int($_[0] + 0.5) == $_[0] + 1.0 ? int($_[0]) : int($_[0] + 0.5)} 
print "</PRE></BODY></HTML>";
