#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
use PDFJ::Shape; #PDFJ::Shapeモジュールを明示的にインポート
$doc = new PDFJ::Doc(1.5,200,200); #PDFバージョン1.5で文書生成
$page = $doc->new_page();
$shape = Shape(SStyle(strokecolor => Color("#ff0000")));#線色を設定
$image = $doc->new_image("sample.jpg",606,492,20,20); #JPEG読み込み
$shape->arrow(20,20,20,80,10,.5); #矢印描画
$shape->obj($image,[20,20]);      #イメージ描画
$shape->show($page,20,50);
$doc->print("-");
