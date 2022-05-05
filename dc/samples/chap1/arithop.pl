#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = 5;
$b = 3;
print $a + $b;      #加算。結果：8
print "\n";
print $a - $b;      #減算。結果：2
print "\n";
print $a * $b;      #乗算。結果：15
print "\n";
print $a / $b;      #除算。結果：1.66666666666667
print "\n";
print $a % $b;      #除算の余り。結果：2
print "\n";
print $a ** $b;     #べき乗。結果：125
print "\n";
print "3fskj" + "423fds";  #文字列の先頭を数値とみなして加算。結果：426
print "\n";
print "43jfkew" - "fgrwe"; #先頭に数字がない場合は0とみなす。結果：43
print "\n";
print int($a / $b); #除算の商。結果：1
print "\n";
print 10.5 / 3.8;   #小数点の除算。結果：2.76315789473684
print "\n";
print 10.5 % 3.8;   #小数点の除算の余り。結果：1
print "\n";
#print 2 / 0;        #0で除算。例外発生
#結果：Illegal division by zero at C:\src\chap1\arithop.pl line 14.
#print 2 % 0;        #0で除算の余り。例外発生
#結果：Illegal modulus zero at C:\src\chap1\arithop.pl line 16.
print 100000000000 ** 10000000000; #桁あふれ。結果：1.#INF
print "\n";
$a = -5;
$b = 3;
print +$a; #+演算子を使用するが効果はない。結果：-5
print "\n";
print -$a; #-演算子で符号を反転させる。結果：5
print "\n";
print -$b; #-演算子で符号を反転させる。結果：-3
print "</PRE></BODY></HTML>";
