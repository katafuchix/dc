#!/user/local/perl
print "Content-type: image/jpeg\n\n"; #HTTP�w�b�_�o��

use GD;
$img = newFromPng GD::Image('./gd_sample.PNG'); # gd_sample.PNG��ǂݍ���
binmode STDOUT;                                 # �o�C�i���o�͂ɐݒ�
print $img->jpeg(10);                           # JPEG�`���Œ�掿�̉摜���o�͂���

