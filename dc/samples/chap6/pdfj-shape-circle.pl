#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFバージョン1.5で文書生成
$page = $doc->new_page();
$shape = Shape(SStyle(strokecolor => Color("#ff0000")));#線色を設定
$shape->circle(20,20,20); #円描画
$shape->show($page,20,100);
$doc->print("-");
