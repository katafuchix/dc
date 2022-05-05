#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header(-charset => "shift-jis");            #HTTPヘッダ出力
print $q->start_html(-title => "sample title",);      #HTMLヘッダ出力
print $q->p(
  $q->comment("コメント内容")   #HTMLコメント出力
  );
print $q->end_html();        #HTML終了
