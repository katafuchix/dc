#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$str = "abcdefghijk 12345 abcdefg";
while($str =~ m/cde/g){ #"cde"��m//g�T�[�`
  print pos $str;       #�}�b�`�ʒu���o�́B���ʁF5,23
}
print "\n";
pos $str = 10;          #����̃p�^�[���}�b�`���O��10�����ڂ���ɐݒ�
while($str =~ m/cde/g){ #"cde"��m//g�T�[�`
  print pos $str;       #�}�b�`�ʒu���o�́B5�����ڂ̓}�b�`���Ȃ��B���ʁF23
}
print "</PRE></BODY></HTML>";
