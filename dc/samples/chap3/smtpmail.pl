#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Net::SMTP;
use Encode;
$smtp = Net::SMTP->new('mailserver');          #mailserver�T�[�o�ɐڑ�
$smtp->mail('from@virtualdomain');             #���[�����M�J�n
$smtp->to('to@virtualdomain2');                #����w��
$smtp->data();                                 #�f�[�^���M�J�n
$smtp->datasend("From: from\@virtualdomain\n");#���[����From�w�b�_���M
$smtp->datasend("To: to\@virtualdomain2\n");   #���[����To�w�b�_���M
$subject = "����ɂ��́I";                     #���{��Subject
Encode::from_to($subject,"shiftjis","iso-2022-jp"); #�����R�[�h��JIS�ɕϊ�
$smtp->datasend("Subject:$subject \n");        #���[����Subject�w�b�_���M
$smtp->datasend("\n");                         #���[���w�b�_�I��
$smtp->datasend("Hello Net::SMTP World!\n");   #���[���̖{�����M
$body = "�����C�ł���";
Encode::from_to($body,"shiftjis","iso-2022-jp"); #�����R�[�h��JIS�ɕϊ�
$smtp->datasend($body);                        #���M
$smtp->dataend();                              #�f�[�^���M�I���B���[�����M
$smtp->quit;                                   #SMTP�I��
print "</PRE></BODY></HTML>";
