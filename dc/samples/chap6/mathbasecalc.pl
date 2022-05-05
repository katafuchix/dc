#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BaseCalc;
$base5 = new Math::BaseCalc(digits => [0..4]);         #0�`4��p����5�i��
$base7 = new Math::BaseCalc(digits => [0..4,'a','B']);
#0�`4��a��B��p�����ϑ�7�i��
print $base5->to_base(20);  #20��5�i�����B���ʁF40
print "\n";
print $base7->to_base(20);  #20��ϑ�7�i�����B���ʁF2B�i7 * 2 + 6�j
print "\n";
print $base7->to_base( $base5->from_base("400")); #5�i������7�i���֕ϊ�
#5�i����400��10�i��100��7�i��202(7**2 * 2 + 7**1 * 0 + 2)�B���ʁF202
print "\n";
print $base7->digits(); #�p���Ă��鐔�l���X�g���o�́B���ʁF01234aB
print "\n";
$base7->digits(['a','b','c']); #7�i����abc��p����3�i���ɕύX
print $base7->to_base(20);  #20��3�i�����B���ʁFcac
print "\n";
$hex = new Math::BaseCalc(digits => "hex"); #������16�i��
print $hex->digits(); #�p���Ă��鐔�l���X�g���o�́B���ʁF0123456789abcdef
print "\n";
$bin = new Math::BaseCalc(digits => "bin"); #2�i��
print $bin->digits(); #�p���Ă��鐔�l���X�g���o�́B���ʁF01
print "\n";
print $hex->to_base($bin->from_base("1011110")); #2�i������16�i���֕ϊ�
#���ʁF5e
print "</PRE></BODY></HTML>";
