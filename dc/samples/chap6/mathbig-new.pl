#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("1.234567890e+500"); #Math::BigInt�C���X�^���X
$zero = Math::BigInt->bzero();   #0��\��Math::BigInt�C���X�^���X
$one =  Math::BigInt->bone("-"); #-1��\��Math::BigInt�C���X�^���X
print $bigv; #���ʁF123456789000000000000000000000000...
print "\n";
print $zero; #���ʁF0
print "\n";
print $one;  #���ʁF-1
print "\n";
print $bigv->numify(); #�X�J���ϐ��ł͈����Ȃ��B���ʁF-1.#IND
print "</PRE></BODY></HTML>";
