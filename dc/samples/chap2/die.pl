#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
#chdir "zzzz" || die "�I���F$!"; #���݂��Ȃ��t�H���_�ֈړ��B���s������I��
 #���ʁF�I���FNo such file or directory at C:\src\chap2\die.pl line 1.

eval{ chdir "zzzz" || die "CD failed..."}; #eval���ő��݂��Ȃ��t�H���_�ֈړ�
 #die�֐����Ăяo����邪�Aeval�֐����I�����邾��

if($@){                         #$@�ɃG���[���b�Z�[�W�������Ă��邩
  print "eval����die:".$@;      #�G���[���b�Z�[�W�\��
} #���ʁFeval����die:CD failed... at C:\src\chap2\die.pl line 3.
print "</PRE></BODY></HTML>";
