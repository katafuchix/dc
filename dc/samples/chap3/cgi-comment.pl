#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header(-charset => "shift-jis");            #HTTP�w�b�_�o��
print $q->start_html(-title => "sample title",);      #HTML�w�b�_�o��
print $q->p(
  $q->comment("�R�����g���e")   #HTML�R�����g�o��
  );
print $q->end_html();        #HTML�I��
