#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header(-charset => "shift-jis");            #HTTP�w�b�_�o��
print $q->start_html(-title => "sample title",);      #HTML�w�b�_�o��
print $q->p($q->escapeHTML("HTML�G�X�P�[�v���镶����<�A>�A&"));
print $q->end_html();        #HTML�I��
