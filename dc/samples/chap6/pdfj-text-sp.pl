#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$font = $doc->new_font("Ryumin-Light", "90ms-RKSJ-H", "Times-Roman");
@list = ["�e�L�X�g",NewLine(),"�e�L�X�g2"];
 #����I�u�W�F�N�g����
$text = Text(@list,TStyle(font => $font , fontsize => 10));
$para = Paragraph($text ,PStyle(size => 500 , align => "w" ,linefeed => 15 ));
$para->show($page,100,100);
$doc->print("-");
#�i�����ŋ������s���s��
