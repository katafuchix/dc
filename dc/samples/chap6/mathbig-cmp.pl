#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("-1.234567890e+500"); #Math::BigInt�C���X�^���X
$bigv2 = $bigv + 1;
print $bigv->bcmp($bigv2); #���l��r�Bbigv�̕����������B���ʁF-1
print "\n";
print $bigv->bacmp($bigv2);#���l��r�Bbigv�̕�����Βl�͑傫���B���ʁF1
print "\n";
print $bigv->bcmp($bigv);  #�����Ɣ�r�B�������B���ʁF0
print "</PRE></BODY></HTML>";
