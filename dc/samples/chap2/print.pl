#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open OUTFILE,">sample.txt";
print OUTFILE "print test";    #���ʁFprint test
print "\n";
printf OUTFILE "%03d",20;      #���ʁF020
print "\n";
printf OUTFILE "%+2.3f",3.1415;        #���ʁF+3.142
close OUTFILE;
print "</PRE></BODY></HTML>";
