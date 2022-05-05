#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = "Hello";$b = "World";$c = "Hello";
print $a eq $c; #等しい。結果：1
print "\n";
print $a ne $b; #等しくない。結果：1
print "\n";
$d = "a";$e = "b";
print $d lt $e; #"a"の方が小さいので真。結果：1
print "\n";
print $a cmp $b;#"World"の方が大きい。結果：-1
print "</PRE></BODY></HTML>";
