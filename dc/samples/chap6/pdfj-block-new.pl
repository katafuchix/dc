#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFバージョン1.5で文書生成
$page = $doc->new_page();
$font = $doc->new_font("Ryumin-Light", "90ms-RKSJ-H", "Times-Roman");
$text1 = Text("テキスト1",TStyle(font => $font , fontsize => 10));
$text2 = Text("テキスト2",TStyle(font => $font , fontsize => 10));
$text3 = Text("テキスト3",TStyle(font => $font , fontsize => 10));
$text4 = Text("テキスト4",TStyle(font => $font , fontsize => 10));
$block = Block("R",[$text1,$text2] ,BStyle()); #右から左に並べる
$block->show($page,20,190);
$block = Block("HV",[[$text1,$text2],[$text3,$text4]] ,BStyle()); #配列で並べる
$block->show($page,50,150);
$block = Block("TV",[$text1,[$text2,$text3,$text4]] ,BStyle(levelskip => 10,connectline => "s")); #ツリー状に並べる
$block->show($page,50,100);
$doc->print("-");
