#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"readsample.txt";   #readsample.txt�̓T�C�Y17�o�C�g
print read INFILE,$str,20;      #���ۂɓǂݍ��߂��̂�17�o�C�g�B���ʁF17
close INFILE;
open INFILE,"readsample.txt";   #�t�@�C�����J��
@in = <INFILE>; #���X�g�R���e�L�X�g��<>���Z�q�g�p�B�t�@�C�������ׂēǂݍ���
while(<>){                      #�W�����͂���1�s����$_�ɓǂݍ���
  print;                        #$_���o�͂���
}
print "</PRE></BODY></HTML>";
