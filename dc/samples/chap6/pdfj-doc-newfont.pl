#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$minfont = $doc->new_font("Ryumin-Light", "90ms-RKSJ-H", "Times-Roman");
$gotfont = $doc->new_font("c:\\windows\\fonts\\msgothic.ttc:0","90ms-RKSJ-H");
$page = $doc->new_page();
$text = Text("�����t�H���g", TStyle(font => $minfont, fontsize => 10));
$text2 = Text("�S�V�b�N�t�H���g", TStyle(font => $gotfont, fontsize => 10));
$text->show($page,100,100);
$text2->show($page,100,150);
$doc->print("-");
