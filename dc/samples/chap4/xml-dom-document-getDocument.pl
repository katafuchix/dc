#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$root = $document->getDocumentElement();     #ルート要素の取得
print $root->getTagName();                   #要素名出力。結果：sample
print "</PRE></BODY></HTML>";
