#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
use PDFJ::Shape; #PDFJ::Shape���W���[���𖾎��I�ɃC���|�[�g
$doc = new PDFJ::Doc(1.5,200,200); #PDF�o�[�W����1.5�ŕ�������
$page = $doc->new_page();
$shape = Shape(SStyle(strokecolor => Color("#ff0000")));#���F��ݒ�
$image = $doc->new_image("sample.jpg",606,492,20,20); #JPEG�ǂݍ���
$shape->arrow(20,20,20,80,10,.5); #���`��
$shape->obj($image,[20,20]);      #�C���[�W�`��
$shape->show($page,20,50);
$doc->print("-");
