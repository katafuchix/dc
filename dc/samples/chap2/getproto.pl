#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@info = getprotobyname "tcp"; #tcp�̃v���g�R�����擾
print $info[0];               #�v���g�R�����o�́B���ʁFtcp
print "\n";
print $info[1];               #�G�C���A�X�o�́B���ʁFTCP
print "\n";
print $info[2];               #�v���g�R���ԍ��o�́B���ʁF6
print "\n";
@info = getprotobynumber 17;  #�v���g�R���ԍ�17�̃v���g�R�����擾
print $info[0];               #�v���g�R�����o�́B���ʁFudp
print "\n";
print $info[1];               #�G�C���A�X�o�́B���ʁFUDP
print "\n";
print $info[2];               #�v���g�R���ԍ��o�́B���ʁF17
print "</PRE></BODY></HTML>";
