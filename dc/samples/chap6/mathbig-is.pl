#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigInt;
$bigv = Math::BigInt->new("-1.234567890e+500"); #Math::BigInt�C���X�^���X
print $bigv->is_even();#��������B���ʁF1
print "\n";
print $bigv->is_pos(); #��������B���ʁF0
print "\n";
$sign = $bigv * -2;    #-2���|���Đ����ɂ���
print $sign->sign();   #�����擾�B���ʁF+
print "</PRE></BODY></HTML>";
