#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$font = $doc->new_font("Ryumin-Light", "90ms-RKSJ-H", "Times-Roman");
@list = ("1�s��",NewLine(),"2�s��",NewLine(),"3�s��");
$text = Text(\@list,TStyle(font => $font , fontsize => 10));
$para = Paragraph($text ,PStyle(size => 100 , align => W , linefeed => 12));
#�������[�����w��
$para->show($page,50,100);
$doc->print("-");
