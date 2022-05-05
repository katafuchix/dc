#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header();          #HTTPヘッダ出力
print $q->start_html(-title => "sample title",);      #HTMLヘッダ出力
$self = $q->self_url();
print "<a href=\"$self#anchor\">Link to 1</a>";
print "<a name=\"#anchor\">Link target</a>";
print $q->end_html();        #HTML終了
