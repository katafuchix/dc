#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
setprotoent 1;              #�v���g�R�����擾�J�n
while(@info = getprotoent){ #�v���g�R�����擾
  print $info[0];           #�v���g�R�����o�́B���ʁFip icmp tcp...
}
endprotoent;                #�v���g�R�����擾�I��
print "</PRE></BODY></HTML>";
