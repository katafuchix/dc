#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��

use GD;
$img = new GD::Image(100,100);
$white = $img->colorAllocate(255,255,255);   #����ݒ�i�w�i�����ɐݒ肳���j
$red   = $img->colorAllocate(255,0,0);       #�Ԃ�ݒ�
$yellow= $img->colorAllocate(255,255,0);     #���F��ݒ�
$green = $img->colorAllocate(0,255,0);       #�΂�ݒ�
$cyan  = $img->colorAllocate(0,255,255);     #�V�A���i���F�j��ݒ�
$blue  = $img->colorAllocate(0,0,255);       #��ݒ�
$mazen = $img->colorAllocate(255,0,255);     #�}�[���^�i���j��ݒ�
$black = $img->colorAllocate(0,0,0);         #����ݒ�
$img->line(0,10,100,10,$black);              #���Ő�������
$img->line(0,20,100,20,$red);                #�ԂŐ�������
$img->line(0,30,100,30,$yellow);             #���F�Ő�������
$img->line(0,40,100,40,$green);              #�΂Ő�������
$img->line(0,50,100,50,$cyan);               #�V�A���Ő�������
$img->line(0,60,100,60,$blue);               #�Ő�������
$img->line(0,70,100,70,$mazen);              #�}�[���^�Ő�������
binmode STDOUT;                      # �o�C�i���o�͂ɐݒ�
print $img->png();                   #PNG�`���ŉ摜���o�͂���

