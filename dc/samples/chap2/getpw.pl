#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@info = getpwnam 0;      #���[�UID=0�̃��[�U���擾
print $info[0];          #���[�U���o�́B���ʁFroot
print "\n";
print $info[7];          #�z�[���f�B���N�g���o�́B���ʁF/root
print "\n";
print $info[8];          #�V�F���o�́B���ʁF/bin/bash
print "\n";
@info = getpwnam "doi";  #���[�Udoi�̃��[�U���擾
print $info[0];          #���[�U���o�́B���ʁFdoi
print "\n";
print $info[7];          #�z�[���f�B���N�g���o�́B���ʁF/home/doi
print "\n";
print $info[8];          #�V�F���o�́B���ʁF/bin/bash
print "</PRE></BODY></HTML>";
