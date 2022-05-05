#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = "Hello";
$b = "World";
print $a . "," . $b;    #文字列連結。結果：Hello,World
print "\n";
print join ":",($a,$b); #$aと$bを":"で連結して返す。結果：Hello:World
print "\n";
print $a x 4;           #文字列繰り返し。結果：HelloHelloHelloHello
print "\n";
@d = (1,2,3) x 4;       #リストを繰り返す
print @d;               #結果：123123123123
print "</PRE></BODY></HTML>";
