#!/usr/bin/perl
print "Content-type: text/html ; charset=shift-jis\n\n";
print "<HTML><BODY><PRE>";
print 1_2_3;               #���l���e�����B���ʁF123
print "\n";
print 1.2e+5;              #�w���\�L���������_���B���ʁF120000
print "\n";
print 0x3d;                #16�i�����l���e�����B���ʁF61
print "\n";
print 022;                 #8�i�����l���e�����B���ʁF18
print "\n";
$value = 4;
print "\$value is $value"; #�ϐ��͓W�J�����B�ŏ���\�ŃG�X�P�[�v���Ă���
#���ʁF$value is 4
print "\n";
print '\$value is $value'; #�ϐ��͓W�J����Ȃ��B$�̓G�X�P�[�v����Ȃ�
#���ʁF\$value is $value
print "\n";
print "abc\a";             #�r�[�v���o�́B���ʁFabc�i�{�r�[�v���j
print "\n";
print "def\bghi";          #�o�b�N�X�y�[�X�o�́B���ʁFdeghi
print "\n";
print "abc\ndef";          #���s�o�́B���ʁFabc�i���s�jdef
print "\n";
print "abc\udef\Ughij\Ek"; #�啶�����B���ʁFabcDefGHIJ
print "\n";
print "ABC\lDEF\LGHIJ\EK"; #���������B���ʁFABCdEFghijK
print "\n";
print "\045";              #8�i���̕����R�[�h�B���ʁF%
print "\n";
print "\x27";              #16�i���̕����R�[�h�B���ʁF'
print "\n";
print 'a\nbc\\def\'g';     #�V���O���N�H�[�g���ł�\'��\\�ȊO�͓W�J���Ȃ��B
#���ʁFa\nbc\def'g
print "\n";
print q/"abc"/;            #�V���O���N�H�[�g�̑����q//���Z�q�B���ʁF"abc"
print "\n";
print qq/abc\t"def"\n'ghi'\\/; #�_�u���N�H�[�g�����qq//���Z�q�B
#���ʁFabc	"def"�i���s�j'ghi'\
print "</PRE></BODY></HTML>";
