#!/usr/bin/perl
print "Content-type: text/html; charset=shift-jis\n\n";
print "<HTML><BODY><PRE>";
use XML::Simple;                #XML::Simpleモジュール
$xml = new XML::Simple("RootName" => "output"); #インスタンス生成
                                #出力時のルート要素名を指定
$sample = $xml->xml_in("sample.xml");           #XML読み込み
print "$sample->{'test1'}->{'content'}->[0]\n"; #文字列内容出力
print "$sample->{'test1'}->{'content'}->[1]\n";
$sample->{'test1'}->{'content'}->[1] = "modified content"; #内容書き換え
print $xml->xml_out($sample);   #XML出力
print "</PRE></BODY></HTML>";
