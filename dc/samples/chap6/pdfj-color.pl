#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$shape = Shape(SStyle(strokecolor => Color("#ff0000")));#���F��Ԑݒ�
$shape->line(0,0,10,10); #���`��
$shape->line(10,10,10,10,SStyle(strokecolor => Color(0,.9,.2))); #�Όn�F�Ő��`��
$shape->line(20,20,10,10,SStyle(strokecolor => Color(0))); #���Ő��`��
$shape->show($page,20,50);
$doc->print("-");
