#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("1234567890"); #Math::BigInt�C���X�^���X
print $bigv->as_hex();            #16�i��������
#���ʁF0x499602d2
print "</PRE></BODY></HTML>";
