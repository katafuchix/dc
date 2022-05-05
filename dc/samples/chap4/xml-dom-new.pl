#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
print $document->getDocumentElement->getTagName();
#ルート要素のタグ名出力。結果：sample
print "\n";
$document2 = $xml->parse("<test><test2/></test>"); #XML文字列読み込み
print $document2->getDocumentElement->getTagName();
#ルート要素のタグ名出力。結果：test
print "</PRE></BODY></HTML>";
