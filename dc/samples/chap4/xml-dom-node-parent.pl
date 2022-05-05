#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$node = $document->getDocumentElement();     #ルート要素取得
print $node->getParentNode()->getNodeName(); #親ノードを取得してノード名取得
 #親ノードはDocumentクラス。結果：#document
print "\n";
$newNode =$document->createElement("newElement"); #新しい要素作成
print $newNode->getParentNode();             #親ノードは存在せず。結果：（なし）
print "</PRE></BODY></HTML>";
