#!/usr/bin/perl
use CGI;
$q = new CGI();
#print $q->header();          #HTTP���X�|���X�w�b�_�o�͂����Ă͂Ȃ�Ȃ�
print $q->redirect("http://".$q->server_name()."/chap3/cgi-redirect-2.pl");
#�����T�[�o��cgi-redirect-2.pl�Ƀ��_�C���N�g
