#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open OUTFILE,">flock.txt";    #�t�@�C�����������ݗp�ɊJ��
flock OUTFILE,2;              #�r�����b�N��������
print OUTFILE "�r�����b�N��"; #��������
flock OUTFILE,8;              #���b�N����
close OUTFILE;
print "</PRE></BODY></HTML>";
