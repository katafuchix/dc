#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::Parser;
$parser = HTML::Parser->new(text_h => [\@array,"event,text"],
                            start_h => [\&handlerStart,"event,tagname"]);
#text、startイベントのハンドラにサブルーチン、配列を指定
$parser->parse_file("sample.html");#HTML読み込み
foreach $i(@array){          #textイベントの結果を順に取得
  print "event : $i->[0]\n"; #配列の0番目はevent。結果：text
  print "text : $i->[1]\n";  #配列の1番目はtext。結果：Sample 2
}
sub handlerStart{            #startイベントのハンドラサブルーチン
  ($event,$tagname) = @_;    #イベント名とタグ名取得
  print $tagname;            #開始したタグ名を出力。結果：html body a img
}
print "</PRE></BODY></HTML>";
