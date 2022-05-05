#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$root = $document->getDocumentElement();
$text = $document->createTextNode("test");   #Textノード新規作成
$root->appendChild($text);                   #ルート直下に追加
$text2 = $document->createTextNode("test");  #Textノード新規作成
$root->appendChild($text2);                  #ルート直下に追加
$text3 = $document->createTextNode("test");  #Textノード新規作成
$root->appendChild($text3);                  #ルート直下に追加
print $root->getChildNodes()->getLength();   #ルート直下のノード数出力。結果：8
print "\n";
$root->normalize();                          #テキストノード統合
print $root->getChildNodes()->getLength();   #ルート直下のノード数出力。結果：5
print "</PRE></BODY></HTML>";
