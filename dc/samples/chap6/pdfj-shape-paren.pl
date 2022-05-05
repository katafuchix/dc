#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
use PDFJ::Shape; #PDFJ::Shapeモジュールを明示的にインポート
$doc = new PDFJ::Doc(1.5,200,200); #PDFバージョン1.5で文書生成
$page = $doc->new_page();
$shape = Shape(SStyle(strokecolor => Color("#ff0000")));#線色を設定
$shape->brace(20,0,10,30); #波カッコ描画
$shape->bracket(20,50,30,10); #角カッコ描画
$shape->paren(20,80,10,10); #丸カッコ描画
$shape->show($page,20,50);
$doc->print("-");
