#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Net::FTP;                     #Net::FTP���W���[���ǂݍ���
$ftp = Net::FTP->new("ftpserver");#ftpserver�T�[�o�ɐڑ�
$ftp->login();                    #anonymous���O�C��
$ftp->port();                     #�|�[�g�ԍ������Ńf�[�^�R�l�N�V�����ڑ�
$ftp->mkdir("sub1/sub2",1);       #sub1/sub2�f�B���N�g�����쐬
$ftp->cwd("sub1/sub2");           #sub1/sub2�f�B���N�g���ֈړ�
print $ftp->pwd();                #�J�����g�f�B���N�g���\���B���ʁF/sub1/sub2
$ftp->quit();                     #�ڑ��I��
print "</PRE></BODY></HTML>";
