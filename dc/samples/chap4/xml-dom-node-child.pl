#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$node = $document->getDocumentElement();     #ルート要素取得
print $node->getFirstChild()->getNodeName(); #最初のノード。結果：#text
print "\n";
print $node->getChildAtIndex(1)->getNodeName(); #1番目ノード。結果：test1
print "\n";
print $node->getLastChild()->getNodeName();  #最後のノード。結果：#text
print "\n";
$nodelist = $node->getChildNodes();          #子ノード集合取得
print $nodelist->item(1)->getNodeName();     #子ノード集合の1番目。結果：test1
print "</PRE></BODY></HTML>";
