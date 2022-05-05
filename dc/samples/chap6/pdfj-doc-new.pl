#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,400,300); #PDFバージョン1.5、400x300ポイントで文書生成
$doc->new_page();                    #ページ生成
$doc->print("-");
