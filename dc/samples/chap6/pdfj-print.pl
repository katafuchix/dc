#!/usr/bin/perl
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$font = $doc->new_font("Ryumin-Light", "90ms-RKSJ-H", "Times-Roman");
$text = Text("Text",TStyle(font => $font , fontsize => 10));
$text->show($page,0,200,"tl");  #��񂹁^���񂹂ŏo��
$doc->print("sample-show.pdf"); #PDF�o��
print "content-type: application/pdf\n\n"; #HTTP���X�|���X�w�b�_�o��
$doc->print("-"); #�W���o��
