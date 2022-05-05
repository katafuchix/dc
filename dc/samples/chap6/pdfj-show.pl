#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFバージョン1.5で文書生成
$page = $doc->new_page();
$font = $doc->new_font("Ryumin-Light", "90ms-RKSJ-H", "Times-Roman");
$text = Text("Text",TStyle(font => $font , fontsize => 10));
$text->show($page,0,200,"tl");  #上寄せ／左寄せで出力
$doc->print("-");
