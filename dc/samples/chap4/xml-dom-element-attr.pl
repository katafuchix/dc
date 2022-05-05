#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$test1node = $document->getDocumentElement->getChildAtIndex(1); #要素取得
$attr1 = $test1node->getAttributeNode("attr1"); #属性ノード取得
print $attr1->getValue();                    #属性値出力。結果：attr1 value
print "\n";
print $test1node->setAttribute("attr1","new value"); #属性値設定
print "\n";
print $test1node->getAttribute("attr1");     #属性値出力。結果：new value
print "</PRE></BODY></HTML>";
