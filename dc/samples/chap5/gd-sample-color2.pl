#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��

use GD;
$img = new GD::Image(100,100);
$white = $img->colorAllocate(255,255,255);   # ����ݒ�i�w�i�����ɐݒ肳���j
$blue  = $img->colorAllocate(0,0,255);       # ��ݒ�
$black = $img->colorAllocate(0,0,0);         # ����ݒ�
$img->rectangle(5,5,95,95,$black);           # �l�p�����ŕ`��
$img->fill(50,50,$blue);                     # �Ŏl�p��h��Ԃ�
binmode STDOUT;                              # �o�C�i���o�͂ɐݒ�
print $img->png();                           #PNG�`���ŉ摜���o�͂���


