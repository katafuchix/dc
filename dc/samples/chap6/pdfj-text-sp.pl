#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFバージョン1.5で文書生成
$page = $doc->new_page();
$font = $doc->new_font("Ryumin-Light", "90ms-RKSJ-H", "Times-Roman");
@list = ["テキスト",NewLine(),"テキスト2"];
 #特殊オブジェクト生成
$text = Text(@list,TStyle(font => $font , fontsize => 10));
$para = Paragraph($text ,PStyle(size => 500 , align => "w" ,linefeed => 15 ));
$para->show($page,100,100);
$doc->print("-");
#段落内で強制改行を行う
