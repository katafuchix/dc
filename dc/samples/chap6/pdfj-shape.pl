#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$shape = Shape(SStyle(fillcolor => Color("#ff0000")));#�h��Ԃ��F��ݒ�
$shape->box(10,10,10,10,f); #��`�`��
$shape->show($page,20,50);
$doc->print("-");
