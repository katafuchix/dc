#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"sample.txt";    #�t�@�C�����J��
while(my $ch = getc INFILE){ #1�o�C�g���ǂݍ���
  print $ch;                 #���ʁF�i�t�@�C���̓��e���o�͂����j
}                            #�I�[�܂ŗ����while���[�v���I������
print "</PRE></BODY></HTML>";
