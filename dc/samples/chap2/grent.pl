#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
setgrent;                #�O���[�v���擾�J�n
while(@info = getgrent){ #�O���[�v���擾
  print $info[0];        #�O���[�v���o�́B���ʁFroot
  print "\n";
  print $info[3];        #�����o���o�́B���ʁFroot bin daemon
}
endgrent;                #�O���[�v���擾�I��
print "</PRE></BODY></HTML>";
