#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("1.234567890e+100"); #Math::BigInt�C���X�^���X
print $bigv->broot(3);#�������B���ʁF2311204240824796109777998374665923
print "\n";
print $bigv->bneg();  #�������]�B���ʁF-2311204240824796109777998374665923
print "</PRE></BODY></HTML>";
