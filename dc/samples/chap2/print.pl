#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open OUTFILE,">sample.txt";
print OUTFILE "print test";    #結果：print test
print "\n";
printf OUTFILE "%03d",20;      #結果：020
print "\n";
printf OUTFILE "%+2.3f",3.1415;        #結果：+3.142
close OUTFILE;
print "</PRE></BODY></HTML>";
