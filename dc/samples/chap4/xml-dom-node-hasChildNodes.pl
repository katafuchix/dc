#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$node = $document->getDocumentElement();     #ルート要素取得
print $document->hasChildNodes();            #子ノードの有無。結果：1
print "</PRE></BODY></HTML>";
