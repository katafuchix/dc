#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"sample.txt";  
open INFILE2,"sample2.txt";
print fileno INFILE;       #���ʁF3
print "\n";
print fileno INFILE2;      #���ʁF4
print "\n";
print fileno STDIN;        #���ʁF0
print "\n";
print fileno STDOUT;       #���ʁF1
print "\n";
print fileno STDERR;       #���ʁF2
print "</PRE></BODY></HTML>";
