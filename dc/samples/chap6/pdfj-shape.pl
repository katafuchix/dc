#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFバージョン1.5で文書生成
$page = $doc->new_page();
$shape = Shape(SStyle(fillcolor => Color("#ff0000")));#塗りつぶし色を設定
$shape->box(10,10,10,10,f); #矩形描画
$shape->show($page,20,50);
$doc->print("-");
