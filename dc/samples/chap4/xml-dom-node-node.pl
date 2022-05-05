#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
print $document->getNodeName(); #DocumentクラスのgetNodeNameは文字列を返す
 #結果：#document
print "\n";
$node = $document->getDocumentElement();     #ルート要素取得
print $node->getNodeName(); #ElementクラスのgetNodeNameはタグ名を返す
 #結果：sample
print "</PRE></BODY></HTML>";
