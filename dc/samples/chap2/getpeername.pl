#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Socket;                               #Socket���W���[���ǂݍ���
$proto = getprotobyname'tcp';             #tcp�v���g�R�����擾
socket SOCKET,PF_INET,SOCK_STREAM,$proto; #�\�P�b�g�쐬
$ipaddr = inet_aton("localhost");         #�z�X�g����IP�A�h���X�ɕϊ�
$paddr = pack_sockaddr_in 80,$ipaddr ;    #localhost:80�ɐڑ�
connect SOCKET,$paddr;                    #HTTP�T�[�o���N�����Ă���ΐڑ�����
$addr = getpeername SOCKET;               #�ڑ���A�h���X�擾
($port,$iaddr) = unpack_sockaddr_in $addr;#�|�[�g�ƃA�h���X�ɕ���
print inet_ntoa $iaddr;                   #�A�h���X���o�́B���ʁF127.0.0.1
print "\n";
print $port;                              #�|�[�g�ԍ����o�́B���ʁF80
print "</PRE></BODY></HTML>";
