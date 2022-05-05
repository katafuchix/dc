#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::Parser;
$parser = HTML::Parser->new();
$parser->handler(start => \&handlerStart,"event,tagname");
$parser->parse_file("sample.html");#HTML読み込み解析
$parser->parse("<head></head>");   #文字列解析
sub handlerStart{            #startイベントのハンドラサブルーチン
  ($event,$tagname) = @_;    #イベント名とタグ名取得
  print $tagname;            #開始したタグ名を出力。結果：html body a img head
  print "\n";
  if($tagname eq "head"){    #headタグを発見したら
    $parser->eof();          #解析終了
  }
}
print "</PRE></BODY></HTML>";
