#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$nodelist = $document->getElementsByTagName("content"); #content要素の集合を取得
print $nodelist->getLength();                #content要素の個数。結果：2
print "\n";
print $nodelist->item(0)->getFirstChild()->getNodeValue();
#0番目のcontent要素のテキストノードの値出力。結果：content string1
print "</PRE></BODY></HTML>";
