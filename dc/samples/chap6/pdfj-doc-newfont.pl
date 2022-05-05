#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFバージョン1.5で文書生成
$minfont = $doc->new_font("Ryumin-Light", "90ms-RKSJ-H", "Times-Roman");
$gotfont = $doc->new_font("c:\\windows\\fonts\\msgothic.ttc:0","90ms-RKSJ-H");
$page = $doc->new_page();
$text = Text("明朝フォント", TStyle(font => $minfont, fontsize => 10));
$text2 = Text("ゴシックフォント", TStyle(font => $gotfont, fontsize => 10));
$text->show($page,100,100);
$text2->show($page,100,150);
$doc->print("-");
