#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
if (ref($var) eq "HASH") { #�^�𔻒肷��
  print "$var�͘A�z�z��";  #�A�z�z��̏ꍇ
}
print ref(\&subA);         #�T�u���[�`���̃��t�@�����X�B���ʁFCODE
print "\n";
print ref($a);             #���t�@�����X�ł͂Ȃ��B���ʁF�i�Ȃ��j
sub subA{
}
print "</PRE></BODY></HTML>";
