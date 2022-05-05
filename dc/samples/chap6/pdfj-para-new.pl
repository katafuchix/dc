#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFバージョン1.5で文書生成
$page = $doc->new_page();
$font = $doc->new_font("Ryumin-Light", "90ms-RKSJ-H", "Times-Roman");
@list = ("1行目",NewLine(),"2行目",NewLine(),"3行目");
$text = Text(\@list,TStyle(font => $font , fontsize => 10));
$para = Paragraph($text ,PStyle(size => 100 , align => W , linefeed => 12));
#強制両端揃え指定
$para->show($page,50,100);
$doc->print("-");
