#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��
use GD;
$img = new GD::Image(100,100);               # �V�����摜�I�u�W�F�N�g���쐬
$white = $img->colorAllocate(255,255,255);   # ����ݒ�
$black = $img->colorAllocate(0,0,0);         # ����ݒ�
$img->rectangle(5,10,15,20,$black);          # �������l�p��`��
$img->rectangle(0,0,99,99,$black);           # �傫���l�p��`��
$img->filledRectangle(85,10,95,20,$black);   # ���œh��Ԃ����������l�p��`��
$img->arc(50,30,30,30,0,360,$black);         # �~��`��
$img->arc(50,55,70,30,0,180,$black);         # �����ȉ~��`��
$img->arc(50,90,20,40,180,360,$black);       # �㔼�ȉ~��`��
binmode STDOUT;                              # �o�C�i���o�͂ɐݒ�
print $img->png();                           #PNG�`���ŉ摜���o�͂���

