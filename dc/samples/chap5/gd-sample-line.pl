#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��

use GD;
$img = new GD::Image(100,100);                      # �V�����摜�I�u�W�F�N�g���쐬
$white = $img->colorAllocate(255,255,255);   #����ݒ�
$black = $img->colorAllocate(0,0,0);         #����ݒ�
$img->setPixel(50,50,$black);                # �_��`��
$img->line(5,10,95,10,$black);               # ����`��
$img->dashedLine(5,25,95,25,$black);         # �_����`��
$img->line(5,75,95,75,$black);               # ����`��
$img->dashedLine(5,95,95,95,$black);         # �_����`��
binmode STDOUT;                              # �o�C�i���o�͂ɐݒ�
print $img->png();                           #PNG�`���ŉ摜���o�͂���

