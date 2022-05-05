#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::Simple;                       #XML::Simpleモジュール
$xml = new XML::Simple();              #インスタンス生成
$sample = $xml->xml_in("sample.xml");  #XML読み込み
print $xml->xml_out($sample,RootName => "output"); #XML出力
print "</PRE></BODY></HTML>";
