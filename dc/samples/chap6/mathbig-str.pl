#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("1234567890"); #Math::BigIntインスタンス
print $bigv->as_hex();            #16進数文字列化
#結果：0x499602d2
print "</PRE></BODY></HTML>";
