#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigFloat;
print sqrt 3;        #3の平方根。結果：1.73205080756888
print "\n";
print sqrt sqrt 625; #625の4乗根。結果：5
print "\n";
print nroot(625,4);  #625の4乗根。結果：5
print "\n";
print nroot(8,3);    #8の3乗根。結果：2
print "\n";
print nroot(100,3);  #100の3乗根。結果：4.64158883361278
print "\n";
$float = new Math::BigFloat(100); #Math::BigFloat生成
print $float->broot(3); #100の3乗根
 #結果：4.641588833612778892410076350919446576551
sub nroot { $_[0] ** (1 / $_[1] )} #n乗根関数
print "</PRE></BODY></HTML>";
