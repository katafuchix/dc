#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open OUTFILE,">sample.txt";
print OUTFILE "print test";    #Œ‹‰ÊFprint test
print "\n";
printf OUTFILE "%03d",20;      #Œ‹‰ÊF020
print "\n";
printf OUTFILE "%+2.3f",3.1415;        #Œ‹‰ÊF+3.142
close OUTFILE;
print "</PRE></BODY></HTML>";
