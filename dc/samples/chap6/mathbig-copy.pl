#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("1.234567890e+500"); #Math::BigInt�C���X�^���X
$copy = $bigv->copy();
print $bigv->numify(); #�X�J���ϐ��ł͈����Ȃ��B���ʁF-1.#IND
print "</PRE></BODY></HTML>";
