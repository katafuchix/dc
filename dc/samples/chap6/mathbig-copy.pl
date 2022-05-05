#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("1.234567890e+500"); #Math::BigIntインスタンス
$copy = $bigv->copy();
print $bigv->numify(); #スカラ変数では扱えない。結果：-1.#IND
print "</PRE></BODY></HTML>";
