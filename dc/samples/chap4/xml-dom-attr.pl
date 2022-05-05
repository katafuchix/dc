#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$nodelist = $document->getElementsByTagName("test1"); #content要素の集合を取得
$test1node = $nodelist->item(0); #テキストノード取得
$attrNode = $test1node->getAttributes()->item(0); #最初の属性取得
print $attrNode->getName();      #属性名出力。結果：attr1
print "\n";
print $attrNode->getValue();     #属性値出力。結果：attr1 value
print "</PRE></BODY></HTML>";
