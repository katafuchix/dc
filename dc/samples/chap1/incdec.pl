#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = 5;$b = "A7";$c = "Az";
print $a++; #��ɒu���Ă���̂Œl��Ԃ��Ă���C���N�������g�B���ʁF5
print "\n";
print ++$a; #��ɒu���Ă���̂ŃC���N�������g���Ă���l��Ԃ��B���ʁF7
print "\n";
print --$a; #��ɒu���Ă���̂Ńf�N�������g���Ă���l��Ԃ��B���ʁF6
print "\n";
print $a--; #��ɒu���Ă���̂Œl��Ԃ��Ă���f�N�������g�B���ʁF6
print "\n";
print $a;   #�ϐ��̓f�N�������g����Ă���B���ʁF5
print "\n";
print ++$b; #��������}�W�J���C���N�������g�B���ʁFA8
print "\n";
print ++$c; #�}�W�J���C���N�������g�Ō��グ�����B���ʁFBa
#print ++("Az"); #�R���p�C���G���[�B�}�W�J���C���N�������g�͕ϐ��ɑ΂��Ă̂�
#Can't modify constant item in preincrement (++) at C:\src\chap1\incdec.pl
print "</PRE></BODY></HTML>";
