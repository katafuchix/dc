#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"sample.txt";  
open INFILE2,"sample2.txt";
print fileno INFILE;       #結果：3
print "\n";
print fileno INFILE2;      #結果：4
print "\n";
print fileno STDIN;        #結果：0
print "\n";
print fileno STDOUT;       #結果：1
print "\n";
print fileno STDERR;       #結果：2
print "</PRE></BODY></HTML>";
