#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::PullParser;
$p = HTML::PullParser->new(file => "sample.html", #ファイルから読み込み
       start => "tagname");  #startイベントを補足。タグ名取得
while ($t = $p->get_token()) { #順にイベントを取得していく
  print $t->[0]; #タグ名を出力。結果：html body a img
  print "\n";
}
print "</PRE></BODY></HTML>";
