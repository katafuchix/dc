#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$image = $doc->new_image("sample.jpg",606,492,120,100); #JPEG�ǂݍ���
$image->show($page,20,50);
$doc->print("-");
