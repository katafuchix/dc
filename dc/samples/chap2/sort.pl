#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my @strings = ("Blue","Red","Green");
print sort @strings;             #昇順ソート。結果：BlueGreenRed
print "\n";
print sort {$b cmp $a} @strings; #降順ソート。結果：RedGreenBlue
print "\n";
my @vals = (5,7,2,4);
print sort @vals;                #昇順ソート。結果：2457
print "\n";
print sort {$b <=> $a} @vals;    #降順ソート。結果：7542
print "</PRE></BODY></HTML>";
