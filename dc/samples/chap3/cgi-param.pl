#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header();          #HTTPヘッダ出力
print $q->start_html();      #HTMLヘッダ出力
print $q->url_param("test"); #GETパラメータ取得。
#http://localhost/cgiperl/chap3/cgi-param.pl?test=TestData
#で呼び出し。結果：TestData
print $q->end_html();        #HTML終了
