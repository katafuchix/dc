#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print time; #1970 �N 1 �� 1 �� 00:00:00����̕b���B���ʗ�F1136488544
print "\n";
$time = time;
print scalar localtime($time); #���ʁFThu Feb 23 15:26:57 2006
print "\n";
$time += 60 * 60 * 24; #1�����̕b�������Z
print scalar localtime($time + 1); #Fri Feb 24 15:26:57 2006
print "</PRE></BODY></HTML>";
