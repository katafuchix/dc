#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"readsample.txt";     #readsample.txt�̓T�C�Y17�o�C�g
print sysread INFILE,$str,20;     #�o�b�t�@�����O�Ȃ��ǂݏo���B���ʁF17
close INFILE;
print "</PRE></BODY></HTML>";
