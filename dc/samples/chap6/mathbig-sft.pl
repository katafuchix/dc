#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("-1.234567890e+500"); #Math::BigInt�C���X�^���X
$bigv->blsft(2); #2�i���ō�2�r�b�g�V�t�g�B4�{�ɂȂ�
print $bigv; #���ʁF-4938271560000000.....
print "</PRE></BODY></HTML>";
