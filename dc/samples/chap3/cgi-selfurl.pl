#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header();          #HTTP�w�b�_�o��
print $q->start_html(-title => "sample title",);      #HTML�w�b�_�o��
$self = $q->self_url();
print "<a href=\"$self#anchor\">Link to 1</a>";
print "<a name=\"#anchor\">Link target</a>";
print $q->end_html();        #HTML�I��
