#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parsefile("sample.xml");   #XMLファイル読み込み
$rootElement = $document->getDocumentElement(); #ルート要素取得
print $rootElement->getTagName();            #元のルート要素名。結果：sample
print "\n";
$rootElement->setTagName("newTag");          #要素名を設定
print $rootElement->getTagName();            #新しいルート要素名。結果：newTag
print "</PRE></BODY></HTML>";
