#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open OUTFILE,">sample2.txt";            #�������ݐ�p�Ńt�@�C�����J��
print syswrite OUTFILE,"test",3;        #�擪3�o�C�g�����������݁B���ʁF3
print "\n";
print syswrite OUTFILE,"abcdefg",10,-3; #����3�o�C�g�����������݁B���ʁF3
close OUTFILE;                          #�t�@�C�����e�Ftesefg
print "</PRE></BODY></HTML>";
