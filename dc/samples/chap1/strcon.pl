#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = "Hello";
$b = "World";
print $a . "," . $b;    #������A���B���ʁFHello,World
print "\n";
print join ":",($a,$b); #$a��$b��":"�ŘA�����ĕԂ��B���ʁFHello:World
print "\n";
print $a x 4;           #������J��Ԃ��B���ʁFHelloHelloHelloHello
print "\n";
@d = (1,2,3) x 4;       #���X�g���J��Ԃ�
print @d;               #���ʁF123123123123
print "</PRE></BODY></HTML>";
