#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@info = gethostbyname "www.yahoo.co.jp"; #���O����z�X�g���擾
print $info[0];                          #�z�X�g���o�́B���ʁFwww.yahoo.co.jp
print "\n";
$addr = pack('C4',127,0,0,1);            #�A�h���X��4�o�C�g�Ƀp�b�N
@info = gethostbyaddr $addr,2;           #�A�h���X����z�X�g���擾
print $info[0];                          #�z�X�g�o�́B���ʁFfedora4
print "\n";
print $info[2];                          #�A�h���X�^�C�v�o�́B���ʁF2
print "</PRE></BODY></HTML>";
