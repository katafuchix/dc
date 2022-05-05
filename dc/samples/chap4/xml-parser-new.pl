#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::Parser;                #XML::Parserモジュール
$xml = new XML::Parser(Handlers => {Init => \&handlerInit,
                                    Start => \&handlerStart});
#解析開始イベント、要素開始イベントにハンドラ登録
$sample = $xml->parsefile("sample.xml");           #XML読み込み

sub handlerInit(){
  print "Init handler\n"; #開始時に呼び出される。結果：Init handler
}
sub handlerStart(){
  ($expat,$element) = @_; #要素名を取得
  print $element; #結果：sample test1 content content test2
  print "\n";
}
print "</PRE></BODY></HTML>";
