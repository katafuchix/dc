#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$nodelist = $document->getElementsByTagName("content"); #content要素の集合を取得
$node = $document->getDocumentElement()->getFirstChild()->getNextSibling();
$document2 = $node->getOwnerDocument(); #深い位置からDocumentインスタンスを取得
print $document2->getNodeName();   #ノード名出力。結果：#document
print "</PRE></BODY></HTML>";
