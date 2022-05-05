#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("-1.234567890e+500"); #Math::BigIntインスタンス
$bigv2 = $bigv + 1;
print $bigv->bcmp($bigv2); #数値比較。bigvの方が小さい。結果：-1
print "\n";
print $bigv->bacmp($bigv2);#数値比較。bigvの方が絶対値は大きい。結果：1
print "\n";
print $bigv->bcmp($bigv);  #自分と比較。等しい。結果：0
print "</PRE></BODY></HTML>";
