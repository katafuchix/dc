#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header(-charset => "shift-jis");            #HTTP�w�b�_�o��
print $q->start_html(-title => "sample title",);      #HTML�w�b�_�o��
print $q->p(
  {-valign => 'top'},        #valign�����w��
  $q->h1("���o��1"),         #����q��h1�^�O�o��
  "���ʂ̕�����",            #�^�O�̓��e
  $q->br(),                  #����q��br�^�O�o��
  $q->Link("�����N������")   #�^�O���ƈقȂ郁�\�b�h
  );
print $q->end_html();        #HTML�I��
