#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Net::Ping;                    #Net::POP3���W���[���ǂݍ���
$ping = Net::Ping->new("tcp",10); #TCP�v���g�R���Ń^�C���A�E�g�b��10�b�w��
print $ping->ping("localhost");   #ping���M�B���ʁF1 1 127.0.0.1
print "\n";
print pingecho("localhost");      #ping���M�B���ʁF1 1 127.0.0.1
$ping->close();                   #Net::Ping�C���X�^���X�j��
print "</PRE></BODY></HTML>";
