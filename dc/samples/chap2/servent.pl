#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
setservent 1;              #�T�[�r�X���擾�J�n
while(@info = getservent){ #�T�[�r�X���擾
  print $info[0];          #�T�[�r�X���o�́B���ʁFtcpmux rje echo...
}
endservent;                #�T�[�r�X���擾�I��
print "</PRE></BODY></HTML>";
