#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sub sub_a{           #���������Ȃ��T�u���[�`��
}
&sub_a;               #�T�u���[�`���Ăяo��
sub sum_3scalar($$$){    #3�̃X�J���������Ƃ��Ď󂯎��T�u���[�`��
  #������@_�ɓ����Ă���̂ŁA$_[0]��0�Ԗڂ̈������擾�ł���
  return $_[0] + $_[1] + $_[2]; #3�̃X�J�������v���ĕԂ�
}
print sum_3scalar 1,2,3; #�v���g�^�C�v�ɉ����ČĂяo���B���ʁF6
#print sum_3scalar 1,2;   #�v���g�^�C�v�ɉ���Ȃ��Ăяo���B�R���p�C���G���[
#���ʁFNot enough arguments for main::sum_3scalar at
#      C:\src\chap1\subArgument.pl line 7, near "2;"
print "</PRE></BODY></HTML>";
