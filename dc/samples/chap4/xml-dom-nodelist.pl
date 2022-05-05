#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$rootNode = $document->getDocumentElement(); #ルート要素取得
$nodelist = $rootNode->getChildNodes();      #子要素集合取得
for($i = 0 ; $i < $nodelist->getLength() ; $i++){ #ノード数までforループ
  $node = $nodelist->item($i);               #ノード取得
  print $node->getNodeName(); #ノード名出力。結果：#text test1 test2 #text
  print "\n";
}
print "</PRE></BODY></HTML>";
