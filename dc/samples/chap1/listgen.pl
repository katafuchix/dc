#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@list = (0..10);      #0����10�܂ł̒l�����z��𐶐�
foreach $i (@list){   #�l�����Ɏ��o��
  print $i;           #���ʁF012345678910
}
print "\n";
@list = (2.4..6.3);   #���������_���͐����l�ɕϊ��B2����6�܂ł̔z��𐶐�
foreach $i (@list){   #�l�����Ɏ��o��
  print $i;           #���ʁF23456
}
print "\n";
@list = ("a0".."b3"); #a0����b3�܂ł̒l�����z��𐶐�
#�}�W�J���C���N�������g�Ɠ��l�ɕ�������C���N�������g���Ă���
foreach $i (@list){   #�l�����Ɏ��o��
  print $i;           #���ʁFa0a1a2a3a4a5a6a7a8a9b0b1b2b3
}
print "</PRE></BODY></HTML>";
