#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = "Hello";$b = "World";$c = "Hello";
print $a eq $c; #�������B���ʁF1
print "\n";
print $a ne $b; #�������Ȃ��B���ʁF1
print "\n";
$d = "a";$e = "b";
print $d lt $e; #"a"�̕����������̂Ő^�B���ʁF1
print "\n";
print $a cmp $b;#"World"�̕����傫���B���ʁF-1
print "</PRE></BODY></HTML>";
