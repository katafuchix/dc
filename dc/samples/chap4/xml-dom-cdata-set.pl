#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$nodelist = $document->getElementsByTagName("content"); #content要素の集合を取得
$textnode = $nodelist->item(0)->getFirstChild(); #テキストノード取得
print $textnode->getData();   #文字列出力。結果：content string1
print "\n";
$textnode->appendData("+append"); #文字列を追加
print $textnode->getData();   #文字列出力。結果：content string1+append
print "</PRE></BODY></HTML>";
