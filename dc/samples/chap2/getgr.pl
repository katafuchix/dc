#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@info = getgrnam "root"; #root�̃O���[�v���擾
print $info[0];          #�O���[�v���o�́B���ʁFroot
print "\n";
print $info[2];          #�O���[�vID�o�́B���ʁF0
print "\n";
print $info[3];          #�����o�o�́B���ʁFroot
print "\n";
@info = getgrgid 1;      #�O���[�vID=1�̃O���[�v���擾
print $info[0];          #�O���[�v���o�́B���ʁFbin
print "\n";
print $info[2];          #�O���[�vID�o�́B���ʁF1
print "\n";
print $info[3];          #�����o�o�́B���ʁFroot bin daemon
print "</PRE></BODY></HTML>";
