#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
mkdir "test",0755;         #test�f�B���N�g���쐬
open OUT,">test/test.txt"; #test�f�B���N�g�����Ƀt�@�C���쐬
print OUT "test";
close OUT;
print rmdir "test";        #test�f�B���N�g���͋�łȂ��̂ō폜���s�B���ʁF0
print "\n";
print $!;                  #�G���[���b�Z�[�W���o�́B���ʁFDirectory not empty
print "</PRE></BODY></HTML>";
