#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$node = $document->getDocumentElement();     #ルート要素取得
$clone = $node->cloneNode(0);                #ルート要素のみコピー
print $clone->getNodeName();                 #要素名出力。結果：sample
print "\n";
print $clone->hasChildNodes();               #子ノードの有無。結果：（なし）
print "\n";
$clone2 = $node->cloneNode(1);               #再帰的にコピー
print $clone2->hasChildNodes();              #子ノードの有無。結果：1
print "</PRE></BODY></HTML>";
