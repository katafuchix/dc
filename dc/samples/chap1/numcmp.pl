#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = 10;
$b = 11;
$c = 10;
print $a == $c; #等しい。結果：1
print "\n";
print $a != $b; #等しくない。結果：1
print "\n";
print $a < $b;  #$aが小さいので真。結果：1
print "\n";
print $a <= $b; #$aが小さいので真。結果：1
print "\n";
print $a > $b;  #$aが小さいので偽。結果：（なし）
print "\n";
print $a <=> $b;#$bが大きい。結果：-1
print "</PRE></BODY></HTML>";
