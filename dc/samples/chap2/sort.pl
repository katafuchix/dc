#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my @strings = ("Blue","Red","Green");
print sort @strings;             #�����\�[�g�B���ʁFBlueGreenRed
print "\n";
print sort {$b cmp $a} @strings; #�~���\�[�g�B���ʁFRedGreenBlue
print "\n";
my @vals = (5,7,2,4);
print sort @vals;                #�����\�[�g�B���ʁF2457
print "\n";
print sort {$b <=> $a} @vals;    #�~���\�[�g�B���ʁF7542
print "</PRE></BODY></HTML>";
