#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"sample.txt"; #�t�@�C�����J��
if(not eof INFILE){
  print "non-EOF";        #���ʁFnon-EOF
}
print "\n";
while(<INFILE>){          #�t�@�C���S�̂�ǂݍ���
}
if(eof INFILE){
  print "EOF";            #���ʁFEOF
}
print "</PRE></BODY></HTML>";
