#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��

use GD;
$img = new GD::Image(100,100);
$white = $img->colorAllocate(255,255,255);   #����ݒ�
$black = $img->colorAllocate(0,0,0);         #����ݒ�
$poly = new GD::Polygon;                     # ���p�`�I�u�W�F�N�g���쐬
$poly->addPt(50,0);                          # ���_���W(50,0)��ݒ�
$poly->addPt(99,95);                         # ���_���W(99,95)��ݒ�
$poly->addPt(0,95);                          # ���_���W(0,95)��ݒ�
$img->polygon($poly,$black);                 # �w�肵�����_���q�����O�p�`��`��
binmode STDOUT;                              # �o�C�i���o�͂ɐݒ�
print $img->png();                           #PNG�`���ŉ摜���o�͂���


