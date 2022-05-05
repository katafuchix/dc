#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::Simple;                      #XML::Simpleモジュール
$xml = new XML::Simple();             #インスタンス生成
$sample = $xml->xml_in("sample.xml"); #XML読み込み
print $sample->{test1}->{attr1}; #test1要素のattr1属性を表示。結果：attr1 value
print "\n";
$sample2 = XMLin("sample.xml");       #インスタンス生成無しで呼び出し
print $sample2->{test1}->{attr1};#test1要素のattr1属性を表示。結果：attr1 value
print "</PRE></BODY></HTML>";
