#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header(-charset => "shift-jis");            #HTTPヘッダ出力
print $q->start_html(-title => "sample title",);      #HTMLヘッダ出力
print $q->p($q->escapeHTML("HTMLエスケープする文字列<、>、&"));
print $q->end_html();        #HTML終了
