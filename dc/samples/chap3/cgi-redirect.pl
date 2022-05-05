#!/usr/bin/perl
use CGI;
$q = new CGI();
#print $q->header();          #HTTPレスポンスヘッダ出力もしてはならない
print $q->redirect("http://".$q->server_name()."/chap3/cgi-redirect-2.pl");
#同じサーバのcgi-redirect-2.plにリダイレクト
