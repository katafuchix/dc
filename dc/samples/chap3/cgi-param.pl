#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header();          #HTTP�w�b�_�o��
print $q->start_html();      #HTML�w�b�_�o��
print $q->url_param("test"); #GET�p�����[�^�擾�B
#http://localhost/cgiperl/chap3/cgi-param.pl?test=TestData
#�ŌĂяo���B���ʁFTestData
print $q->end_html();        #HTML�I��
