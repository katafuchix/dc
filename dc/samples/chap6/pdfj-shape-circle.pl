#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$shape = Shape(SStyle(strokecolor => Color("#ff0000")));#���F��ݒ�
$shape->circle(20,20,20); #�~�`��
$shape->show($page,20,100);
$doc->print("-");
