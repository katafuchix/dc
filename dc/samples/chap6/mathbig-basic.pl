#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new('1.234567890e+500'); #Math::BigInt�C���X�^���X
$bigv2 = Math::BigInt->new('5.0e+500'); #Math::BigInt�C���X�^���X
print $bigv->badd($bigv2); #���Z�B���ʁF623456789000000000000000000000000...
print "\n";
print $bigv->bpow(10); #�ׂ���B���ʁF88728590907617398926106457639559958...
print "\n";
print $bigv->bone()->binc(); #1���C���N�������g�B���ʁF2
print "</PRE></BODY></HTML>";
