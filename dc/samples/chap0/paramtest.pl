#!/usr/bin/perl
use CGI;
my $query = new CGI();
print $query->header();                          #HTTP�w�b�_���o��
print $query->start_html();                      #HTML�J�n
print "FirstName : ".$query->param("FirstName"); #���� : tsuyoshi
print $query->br();                              #<br/>�^�O�o��
print "LastName : ".$query->param("LastName");   #���� : doi
print $query->end_html();                        #HTML�I��
