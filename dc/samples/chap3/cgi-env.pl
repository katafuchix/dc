#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header(-charset => "shift-jis");            #HTTPヘッダ出力
print $q->start_html(-title => "sample title",);      #HTMLヘッダ出力
print $q->p("Accept:",$q->Accept());
print $q->p("UA:",$q->user_agent());
print $q->p("Script Name:",$q->script_name());
print $q->p("Remote Host:",$q->remote_host());
print $q->p("Referer:",$q->referer());
print $q->p("Method:",$q->request_method());
print $q->p("Content-type:",$q->content_type());
print $q->p("Server name:",$q->server_name());
print $q->p("Server port:",$q->server_port());
print $q->p("Server software:",$q->server_software());
print $q->end_html();        #HTML終了
