#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sysopen INFILE,"sample.txt",O_RDONLY; #�ǂݎ���p�Ńt�@�C�����J��
print sysread INFILE,$str,10;         #�ǂݍ��݁B���ʁF10
close INFILE;
sysopen OUTFILE,"sample2.txt",O_WRONLY|O_CREATE; #�������ݐ�p�Ńt�@�C�����J��
print OUTFILE "test";
close OUTFILE;
print "</PRE></BODY></HTML>";
