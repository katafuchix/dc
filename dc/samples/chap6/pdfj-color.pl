#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFバージョン1.5で文書生成
$page = $doc->new_page();
$shape = Shape(SStyle(strokecolor => Color("#ff0000")));#線色を赤設定
$shape->line(0,0,10,10); #線描画
$shape->line(10,10,10,10,SStyle(strokecolor => Color(0,.9,.2))); #緑系色で線描画
$shape->line(20,20,10,10,SStyle(strokecolor => Color(0))); #黒で線描画
$shape->show($page,20,50);
$doc->print("-");
