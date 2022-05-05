#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOMモジュール
$xml = new XML::DOM::Parser();               #XML::DOM::Parserインスタンス生成
$document = $xml->parse(<<EOL
<sample><?targetProcessor data1 data2?></sample>
EOL
); #XML文字列解析
$pi = $document->getDocumentElement()->getFirstChild(); #処理命令ノード取得
print $pi->getTarget(); #処理対象出力。結果：targetProcessor
print "\n";
print $pi->getData();   #処理内容出力。結果：data1 data2
print "\n";
$pi->setData("data");   #処理内容設定
print $pi->toString();  #XML出力。結果：<?targetProcessor data?>
print "</PRE></BODY></HTML>";
