#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
setpwent;                #���[�U���擾�J�n
while(@info = getpwent){ #���[�U���擾
  print $info[0];        #���[�U�����o�́B���ʁFroot doi ...
  print "\n";
  print $info[7];        #�z�[���f�B���N�g�����o�́B���ʁF/root /home/doi...
  print "\n";
  print $info[8];        #�V�F�����o�́B���ʁF/bin/sh /bin/bash...
  print "\n";
}       
endpwent;                #���[�U���擾�I��
print "</PRE></BODY></HTML>";
