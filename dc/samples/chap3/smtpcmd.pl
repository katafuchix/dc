#!/usr/bin/perl
use Net::SMTP;
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$smtp = Net::SMTP->new('mailserver'); #mailserver�T�[�o�֐ڑ�
print $smtp->banner(); #�o�i�[���b�Z�[�W�擾�B���ʁFmailserver ESMTP
print $smtp->domain(); #�h���C�����擾�B���ʁFmailserver
$smtp->reset();        #���Z�b�g
$smtp->quit;           #SMTP�I��
print "</PRE></BODY></HTML>";
