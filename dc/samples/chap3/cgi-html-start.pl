#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header(-charaset=>"shift-jis");          #HTTP���X�|���X�w�b�_�o��
print $q->start_html(
  -lang => "ja-JP",
  -title => "sample title",
  -author => "doi\@virtualdomain",
  -base => "true",
  -head=>CGI::meta({-http_equiv => "Content-Type",-content => "text/htmll charset=shift-jis"}),
  -xbase => "virtualdomain",
  -unknownHeader => "test value",
  -bgcolor => "blue"
  );      #HTML�w�b�_�o��
print $q->end_html();        #HTML�I��
