#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
while(glob "*.pl"){ #���ׂẴX�N���v�g�t�@�C�������Ɏ��o��
  print;            #�t�@�C�������ɏo�́B���ʁFabs.pl binmode.pl...
  print "\n";
}
print "</PRE></BODY></HTML>";
