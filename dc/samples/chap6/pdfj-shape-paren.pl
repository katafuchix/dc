#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
use PDFJ::Shape; #PDFJ::Shape���W���[���𖾎��I�ɃC���|�[�g
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$shape = Shape(SStyle(strokecolor => Color("#ff0000")));#���F��ݒ�
$shape->brace(20,0,10,30); #�g�J�b�R�`��
$shape->bracket(20,50,30,10); #�p�J�b�R�`��
$shape->paren(20,80,10,10); #�ۃJ�b�R�`��
$shape->show($page,20,50);
$doc->print("-");
