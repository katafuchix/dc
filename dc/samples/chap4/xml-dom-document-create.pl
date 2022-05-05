#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample2.xml");   #XMLファイル読み込み
$newNode = $document->createElement("newTag"); #要素作成
$document->getDocumentElement->appendChild($newNode); #ルート要素に追加
print $document->toString(); #出力
print "</PRE></BODY></HTML>";
