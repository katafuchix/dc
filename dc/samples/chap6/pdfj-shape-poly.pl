#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$shape = Shape(SStyle(fillcolor => Color("#ff0000")));#�h��Ԃ��F��ݒ�
$shape->polygon([0,0,20,5,30,20,5,20,0,0],"s"); #���p�`�`��B�g���̂�
$shape->show($page,20,100);
$doc->print("-");
