#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Net::POP3;                         #Net::POP3���W���[���ǂݍ���
$pop3 = Net::POP3->new('mailserver');  #mailserver�T�[�o�ɐڑ�
$pop3->login("username","password");   #���[�U��user�A�p�X���[�hpass�ŔF��
($num,$size) = $pop3->popstat();       #���b�Z�[�W���A�T�C�Y�擾
print "Message : $num , Size: $size\n";
$list = $pop3->list();                 #���b�Z�[�W�ꗗ�擾
$uidl = $pop3->uidl();                 #���j�[�NID�擾
foreach $i(keys %$list){               #�L�[�̃��b�Z�[�W�ԍ����擾
  print "$i : $list->{$i} : $uidl->{$i}\n";
  #���b�Z�[�W�ԍ��A�T�C�Y�A���j�[�NID���o��
}
$pop3->quit;
print "</PRE></BODY></HTML>";
