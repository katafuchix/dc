#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"seeksample.txt"; #�ǂݍ��ݐ�p�Ńt�@�C�����J��
sysread INFILE,$str,10;   #�擪10�o�C�g�ǂݍ���
print $str;               #���ʁFabcdefghij
print "\n";
sysseek INFILE,5,0;       #5�o�C�g�ڂɈړ�
sysread INFILE,$str,5;    #5�o�C�g�ǂݍ���
print $str;               #���ʁFfghij
close INFILE;
print "</PRE></BODY></HTML>";
