#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"<sample.txt";     #sample.txt��ǂݍ��ݐ�p�ŊJ��
close INFILE;                  #�t�@�C�������
open OUTFILE,">sample.txt";    #sample.txt���������ݐ�p�ŊJ���i�㏑���j
print OUTFILE "create";        #�t�@�C���ɏ�������
close OUTFILE;
open INOUTFILE,"+<sample.txt"; #sample.txt��ǂݏ������p�ŊJ��
print getc INOUTFILE;          #�t�@�C�����e��1�����ǂݍ��ށB���ʁFc
print "\n";
print INOUTFILE "read/write";  #�t�@�C���ɏ�������
close INOUTFILE;
open OUTFILE,">>sample.txt";   #sample.txt��ǋL�p�ŊJ��
print OUTFILE "append";        #�t�@�C���ɒǋL����
close OUTFILE;
open INFILE,"dir /w/b *.pl|";  #dir�R�}���h�̌��ʂ��p�C�v���́BLinux�ł�ls���g�p
@dir = <INFILE>;               #���ʂ�ǂݎ��
close INFILE;
foreach(@dir){
  print;                      #���ʁFabs.pl accept.pl alarm.pl ...
}
open OUTFILE,"| sort";         #��������\�[�g����sort�R�}���h�Ƀp�C�v�o��
@list = ("xyz","abc","def");   #�\�[�g�O�z��
foreach(@list){
  print OUTFILE;               #OUTFILE�ɕ�����o��
  print OUTFILE "\n";
}
close OUTFILE;                 #OUTFILE�����
#���ʁisort�R�}���h���o�͂���j�F
#abc
#def
#xyz
print "</PRE></BODY></HTML>";
