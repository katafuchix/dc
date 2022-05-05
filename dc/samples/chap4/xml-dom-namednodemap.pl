#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parse("<sample attr1='attr1value' attr2='attr2value'/>");
$nnm = $document->getDocumentElement()->getAttributes(); #属性集合取得
print $nnm->item($i)->getValue(); #属性値出力。結果：attr1value
print "\n";
print $nnm->getNamedItem("attr2")->getValue(); #属性値出力。結果：attr2value
print "</PRE></BODY></HTML>";
