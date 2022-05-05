#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��

use GD;
$img = new GD::Image(100,100);
$white = $img->colorAllocate(255,255,255);   #����ݒ�
$black = $img->colorAllocate(0,0,0);         #����ݒ�
$poly = new GD::Polygon;             # ���p�`�I�u�W�F�N�g�̐���
$poly->addPt(10,10);                 # ���_���W(10,10)��ǉ�
$poly->addPt(30,10);                 # ���_���W(30,10)��ǉ�
@x_y = $poly->getPt(1);              # ���_���W(20,10)���擾
$poly->deletePt(1);                  # ���_���W(20,10)���폜
$poly->addPt(@x_y);                  # �擾�������W��ǉ�
$poly->addPt(90,95);                 # ���_���W(90,95)��ݒ�
$poly->setPt(2,10,95);               # ���_���W(90,95)��(10,95)�ɕύX
$img->polygon($poly,$black);         # �w�肵�����_���Ȃ����O�p�`��`��
$poly = new GD::Polygon;             # ���p�`�I�u�W�F�N�g���쐬
$poly->addPt(60,10);                 # ���_���W(60,10)��ݒ�
$poly->toPt (30,10);                 # ���_���W(90,20)��ǉ��i���ΓI�Ɏw��j
$poly->addPt(60,95);                 # ���_���W(60,95)��ݒ�
$img->polygon($poly,$black);         # �w�肵�����_���Ȃ����O�p�`��`��
binmode STDOUT;                      # �o�C�i���o�͂ɐݒ�
print $img->png();                   #PNG�`���ŉ摜���o�͂���


