#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $foo = 'perl';
printf "%c",vec($foo,  0, 8);  #1�����ڂ��o�C�g�P�ʂŐ؂�o���B���ʁFp
print "\n";
printf "%d",vec($foo,  0, 16); #2,3�o�C�g�𐔒l�Ƃ��Đ؂�o���B
print "\n";
#���ʁF28773 = 112�i'p'�j * 256 + 101�i'e'�j�B�擪�o�C�g���疖���o�C�g��
vec($val,0,8) = 0x5;       #2�i�l�F00000101
print vec($val,2,1);       #���ʃr�b�g����2�r�b�g�X�L�b�v���Đ؂�o���B���ʁF1
print "</PRE></BODY></HTML>";
