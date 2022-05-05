#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFバージョン1.5で文書生成
$page = $doc->new_page();
$image = $doc->new_image("sample.jpg",606,492,120,100); #JPEG読み込み
$image->show($page,20,50);
$doc->print("-");
