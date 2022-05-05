#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFバージョン1.5で文書生成
$page = $doc->new_page();
$shape = Shape(SStyle(fillcolor => Color("#ff0000")));#塗りつぶし色を設定
$shape->polygon([0,0,20,5,30,20,5,20,0,0],"s"); #多角形描画。枠線のみ
$shape->show($page,20,100);
$doc->print("-");
