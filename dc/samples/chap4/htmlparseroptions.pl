#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::Parser;
$parser = HTML::Parser->new(start_h => [\&handlerTag,"tagname"]);
$parser->parse("<emptyTag/>");#文字列解析。タグ名はemptyTag/
$parser->xml_mode(1);         #XMLモード有効
$parser->parse("<emptyTag/>");#文字列解析。タグ名はemptyTag
sub handlerTag{           #startイベントのハンドラサブルーチン
  print @_[0];            #タグ名を出力
  print "\n";
}
print "</PRE></BODY></HTML>";
