#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@info = getnetbyname "loopback"; #loopback�l�b�g���[�N���擾
print $info[0];                  #�l�b�g���[�N���o�́B���ʁFloopback
print "\n";
$addr = pack('C4',127,0,0,1);    #�A�h���X��4�o�C�g�Ƀp�b�N
@info = getnetbyaddr $addr,2;    #�A�h���X����l�b�g���[�N���擾
print $info[0];                  #�l�b�g���[�N���B���ʁFloopback
print "</PRE></BODY></HTML>";
