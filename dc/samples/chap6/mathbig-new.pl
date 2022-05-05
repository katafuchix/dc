#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("1.234567890e+500"); #Math::BigIntインスタンス
$zero = Math::BigInt->bzero();   #0を表すMath::BigIntインスタンス
$one =  Math::BigInt->bone("-"); #-1を表すMath::BigIntインスタンス
print $bigv; #結果：123456789000000000000000000000000...
print "\n";
print $zero; #結果：0
print "\n";
print $one;  #結果：-1
print "\n";
print $bigv->numify(); #スカラ変数では扱えない。結果：-1.#IND
print "</PRE></BODY></HTML>";
