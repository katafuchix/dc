#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Socket;                                       #Socket���W���[���ǂݍ���
socket SOCKET,PF_INET,SOCK_STREAM,getprotobyname'tcp';
connect SOCKET,pack_sockaddr_in 80,inet_aton"localhost"; #HTTP�T�[�o�ɐڑ�
send SOCKET,"GET /\n.",0;          #GET���b�Z�[�W���M
recv SOCKET,$str,1000,0 or die;    #HTTP�T�[�o�����M
print $str;                        #���ʁFHTTP/1.1 200 OK...
print "</PRE></BODY></HTML>";
