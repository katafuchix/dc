#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
for($val = 0 ; $val < 5 ; $val++){ #�悭�p������p�^�[��
  #$val��0�ɏ��������A5�����̊ԃu���b�N���������A���[�v���ƂɃC���N�������g����
  print $val; #���ʁF01234
}
print "\n";
for (1..5){         #�ȗ��L�@�B$_��1����5�܂ŕς��Ȃ��烋�[�v
  print;            #�ȗ��L�@�B$_�̓��e���o�́B���ʁF12345
}
#for(;;){     #�������[�v
#  print "a"; #���ʁFaaaaaaa...
#}
print "</PRE></BODY></HTML>";
