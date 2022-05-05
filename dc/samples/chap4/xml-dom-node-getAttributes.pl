#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$node = $document->getDocumentElement();     #ルート要素取得
$firstElement = $node->getFirstChild();      #最初のノード
$secondElement = $firstElement->getNextSibling(); #次のノードを取得
$attrs = $secondElement->getAttributes();         #属性集合取得
print $attrs->item(0)->getValue();           #0番目の属性値出力。結果attr1 value
print "</PRE></BODY></HTML>";
