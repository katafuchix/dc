#!/usr/bin/perl
use CGI;                #CGI���W���[���̃C���|�[�g
$cgi = new CGI;         #CGI�I�u�W�F�N�g�̐���
print $cgi->header;     #�w�b�_�o��
print $cgi->start_html; #HTML�J�n�^�O�o��
print $cgi->end_html;   #HTML�I���^�O�o��
