#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$ft = $doc->new_font("Courier");
$fti = $doc->new_font("Courier-Oblique");
$ftb = $doc->new_font("Courier-Bold");
$ftbi = $doc->new_font("Courier-BoldOblique");
$doc->italic($ft, $fti);
$doc->italic($ftb,$ftbi);
$doc->bold($ft, $ftb);
$doc->bold($fti,$ftbi);
$text = Text("Normal Test",TStyle(font => $ft , fontsize => 10));
$text->show($page,100,100); #Courier�t�H���g
$text2 = Text("Italic Test",TStyle(font => $ft , fontsize => 10, italic => 1));
$text2->show($page,100,120); #�C�^���b�N�w�肷���Courier-Oblique���g�p�����
$text2 = Text("Italic Bold Test",TStyle(font => $ft , fontsize => 10, bold => 1, italic => 1));
$text2->show($page,100,140);
 #�C�^���b�N�{�[���h�w�肷���Courier-BoldOblique���g�p�����
$doc->print("-");
