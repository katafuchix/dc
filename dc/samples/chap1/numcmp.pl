#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = 10;
$b = 11;
$c = 10;
print $a == $c; #�������B���ʁF1
print "\n";
print $a != $b; #�������Ȃ��B���ʁF1
print "\n";
print $a < $b;  #$a���������̂Ő^�B���ʁF1
print "\n";
print $a <= $b; #$a���������̂Ő^�B���ʁF1
print "\n";
print $a > $b;  #$a���������̂ŋU�B���ʁF�i�Ȃ��j
print "\n";
print $a <=> $b;#$b���傫���B���ʁF-1
print "</PRE></BODY></HTML>";
