#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header(-charaset=>"shift-jis");          #HTTPレスポンスヘッダ出力
print $q->start_html(
  -lang => "ja-JP",
  -title => "sample title",
  -author => "doi\@virtualdomain",
  -base => "true",
  -head=>CGI::meta({-http_equiv => "Content-Type",-content => "text/htmll charset=shift-jis"}),
  -xbase => "virtualdomain",
  -unknownHeader => "test value",
  -bgcolor => "blue"
  );      #HTMLヘッダ出力
print $q->end_html();        #HTML終了
