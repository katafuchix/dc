#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sethostent 0;              #�z�X�g���擾�J�n
while(@info = gethostent){ #�z�X�g���擾
  print $info[0];          #�z�X�g���o�́B���ʁFfedora4
}
endhostent;                #�z�X�g���擾�I��
print "</PRE></BODY></HTML>";
