#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"sample.txt";
read INFILE,$str,5;       #5�o�C�g�ǂݍ���
my $pos = tell INFILE;    #���݂̓ǂݏ����ʒu��ۑ�
print $pos;               #���ʁF5
print "\n";
read INFILE,$str,5;       #5�o�C�g�ǂݍ���
print tell INFILE;        #���ʁF10
print "\n";
seek INFILE,$pos,0;       #�ۑ����Ă������ʒu�Ɉړ�
print tell INFILE;        #���ʁF5
print "\n";
seek INFILE,5,1;          #���݈ʒu����5�o�C�g�ړ�
print tell INFILE;        #���ʁF10
print "\n";
seek INFILE,5,2;          #�t�@�C����������5�o�C�g�̈ʒu�Ɉړ�
print tell INFILE;        #���ʁF24
print "</PRE></BODY></HTML>";
