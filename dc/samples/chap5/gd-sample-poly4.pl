#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��

use GD;
$img = new GD::Image(200,200);
$white = $img->colorAllocate(255,255,255);   #����ݒ�
$black = $img->colorAllocate(0,0,0);         #����ݒ�
$poly = new GD::Polygon;             # ���p�`�I�u�W�F�N�g���쐬
$poly->addPt(10,10);                 # ���_���W(10,10)��ǉ�
$poly->addPt(30,10);                 # ���_���W(30,10)��ǉ�
$poly->addPt(10,35);                 # ���_���W(10,35)��ǉ�
@poly_bounds = $poly->bounds;        # �O�p�`������ŏ��̎l�p�`�̒��_���擾
                                     # ���̏ꍇ�͍���(10,10)�E��(30,35)�̎l�p�`
$img->filledPolygon($poly,$black);   # �O�p�`��`��
$img->rectangle(@poly_bounds,$black);# bound�Ŏ擾�����l�p�`��`��
# ����(10,10)�E��(30,35)�̎l�p�`�Ɏ��܂��Ă���O�p�`��
# ����(5,0)�E��(50,50)�̎l�p�`�Ɏ��܂�悤�ό`����
$poly->map(@poly_bounds,5,0,50,50); 
$img->polygon($poly,$black);         # �ό`��̎O�p�`��`��
$poly->offset(30,30);                # �O�p�`��x������30�Ay������30�ړ�����
# ���_��(10,10)��(40,40) (30,10)��(60,40) (10,35)��(40,65)�ƂȂ�
$img->polygon($poly,$black);         # �ړ���̎O�p�`��`��
$poly->scale(2,2);                   # ���_���W��2�{�ɂ��ĎO�p�`��ό`����
# (40,40)��(80,80) (60,40)��(120,80) (40,65)��(80,130)
$img->filledPolygon($poly,$black);   # �g���̎O�p�`��`��
binmode STDOUT;                      # �o�C�i���o�͂ɐݒ�
print $img->png();                   #PNG�`���ŉ摜���o�͂���


