#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::Parser;                #XML::Parserモジュール
$xml = new XML::Parser();
$xml->setHandlers(Start,\&handlerStart);
#要素開始イベントにハンドラ登録
$xml->parsefile("sample.xml"); #XMLファイル解析
$xml->parse("<parsetest><test/></parsetest>"); #XML文字列解析
sub handlerStart(){
  ($expat,$element) = @_; #要素名を取得
  print $element; #結果：sample test1 content content test2 parsetest test
  print "\n";
}
print "</PRE></BODY></HTML>";
