#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Net::FTP;                     #Net::FTP���W���[���ǂݍ���
$ftp = Net::FTP->new("ftpserver");#ftpserver�T�[�o�ɐڑ�
$ftp->login();                    #anonymous���O�C��
$ftp->port();                     #�|�[�g�ԍ������Ńf�[�^�R�l�N�V�����ڑ�
print $ftp->ls();                 #�t�@�C�����X�g���擾
#���ʁFsample.txt
print $ftp->dir();                #�t�@�C�����X�g�𒷂��`���Ŏ擾
#���ʁF02-10-06  05:38PM                    4 sample.txt
$ftp->quit();                       #�ڑ��I��
print "</PRE></BODY></HTML>";
