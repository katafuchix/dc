#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
setnetent;                #�l�b�g���[�N���擾�J�n
while(@info = getnetent){ #�l�b�g���[�N���擾
  print $info[0];         #�l�b�g���[�N���o�́B���ʁFloopback
}
endnetent;                #�l�b�g���[�N���擾�I��
print "</PRE></BODY></HTML>";
