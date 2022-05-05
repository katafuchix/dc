#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$node = $document->getDocumentElement();     #ルート要素取得
$newNode = $document->createElement("newTag"); #新しい要素を作成
$node->appendChild($newNode);                #末尾に追加
print $node->getLastChild()->getNodeName();  #最後の子ノードの名前。結果：newTag
print "</PRE></BODY></HTML>";
