#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$font = $doc->new_font("Ryumin-Light", "90ms-RKSJ-H", "Times-Roman");
$text = Text("�e�L�X�g�I�u�W�F�N�g",TStyle(font => $font , fontsize => 10));
$text->show($page,50,100);
$doc->print("-");
