#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("4"); #Math::BigInt�C���X�^���X
$bigv2 = Math::BigInt->new("6"); #Math::BigInt�C���X�^���X
print $bigv->band($bigv2); #100 & 110 = 100�B���ʁF4
print "\n";
print $bigv->bxor($bigv2); #100 ^ 110 = 010�B���ʁF2
print "</PRE></BODY></HTML>";
