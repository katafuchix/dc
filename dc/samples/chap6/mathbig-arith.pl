#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("1.234567890e+100"); #Math::BigIntインスタンス
print $bigv->broot(3);#立方根。結果：2311204240824796109777998374665923
print "\n";
print $bigv->bneg();  #符号反転。結果：-2311204240824796109777998374665923
print "</PRE></BODY></HTML>";
