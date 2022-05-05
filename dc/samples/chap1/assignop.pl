#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = 4;
$b = 3;
$a += $b; #$a = $a + $bと同じ
print $a; #4 + 3。結果：7
print "\n";
$a *= $b; #$a = $a * $bと同じ
print $a; #7 * 3。結果：21
print "\n";
$c = "Hello";
$d = "World";
$c .= $d; #$c = $c . $d。文字列連結
print $c; #結果：HelloWorld
print "\n";
$d x= 3;  #$dを3回繰り返して代入
print $d; #結果：WorldWorldWorld
print "\n";
$e = 5;   #2進数で101
$f = 10;  #2進数で1001
$e |= $f; #$e = $e | $f
print $e; #ビット論理和の結果は1111。結果：15（1111）
print "</PRE></BODY></HTML>";
