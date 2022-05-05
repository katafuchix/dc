#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$font = $doc->new_font("Ryumin-Light", "90ms-RKSJ-H", "Times-Roman");
$text1 = Text("�e�L�X�g1",TStyle(font => $font , fontsize => 10));
$text2 = Text("�e�L�X�g2",TStyle(font => $font , fontsize => 10));
$text3 = Text("�e�L�X�g3",TStyle(font => $font , fontsize => 10));
$text4 = Text("�e�L�X�g4",TStyle(font => $font , fontsize => 10));
$block = Block("R",[$text1,$text2] ,BStyle()); #�E���獶�ɕ��ׂ�
$block->show($page,20,190);
$block = Block("HV",[[$text1,$text2],[$text3,$text4]] ,BStyle()); #�z��ŕ��ׂ�
$block->show($page,50,150);
$block = Block("TV",[$text1,[$text2,$text3,$text4]] ,BStyle(levelskip => 10,connectline => "s")); #�c���[��ɕ��ׂ�
$block->show($page,50,100);
$doc->print("-");
