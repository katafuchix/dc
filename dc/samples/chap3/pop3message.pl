#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Net::POP3;                         #Net::POP3���W���[���ǂݍ���
use Encode;                            #Encode���W���[���ǂݍ���
$pop3 = Net::POP3->new('mailserver');  #mailserver�T�[�o�ɐڑ�
$pop3->login("username","password");   #���[�U��user�A�p�X���[�hpass�ŔF��
$mail = $pop3->top(1,3);     #1�ʖڂ̃��b�Z�[�W���w�b�_�ƃ{�f�B3�s�܂Ŏ擾
foreach(@$mail){                       #�e�s�ɂ���
  Encode::from_to($_,"iso-2022-jp","shiftjis"); #�����R�[�h��Shift-JIS�ɕϊ�
  print;                               #���b�Z�[�W���e���o��
}
$pop3->delete(1);                     #1�ʖڂ̃��b�Z�[�W���폜
$pop3->quit;
print "</PRE></BODY></HTML>";
