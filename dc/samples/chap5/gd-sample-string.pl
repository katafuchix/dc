#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��

use GD;
$img = new GD::Image(300,150); #�摜�I�u�W�F�N�g��ݒ�
$white = $img->colorAllocate(255,255,255); #����ݒ�
$black = $img->colorAllocate(0,0,0); #����ݒ�
#gdGiantFont�ŕ������`��
$img->string(gdGiantFont,10,10,"GiantFont",$black);
#gdLargeFont�ŕ������`��
$img->string(gdLargeFont,10,30,"LargeFont",$black);
#gdMediumBoldFont�ŕ������`��
$img->string(gdMediumBoldFont,10,50,"MediumBoldFont",$black);
#gdSmallFont�ŕ������`��
$img->string(gdSmallFont,10,70,"SmallFont",$black);
#gdTinyFont�ŕ������`��
$img->string(gdTinyFont,10,90,"TinyFont",$black);
#gdGiantFont�ŕ������`��(90�x��])
$img->stringUp(gdGiantFont,150,120,"GiantFont90",$black);
#gdLargeFont�ŕ������`��(90�x��])
$img->stringUp(gdLargeFont,170,120,"LargeFont90",$black);
#gdMediumBoldFont�ŕ������`��(90�x��])
$img->stringUp(gdMediumBoldFont,190,120,"MediumBoldFont90",$black);
#gdSmallFont�ŕ������`��(90�x��])
$img->stringUp(gdSmallFont,210,120,"SmallFont90",$black);
#gdTinyFont�ŕ������`��(90�x��])
$img->stringUp(gdTinyFont,230,120,"TinyFont90",$black);
binmode STDOUT; # �o�C�i���o�͂ɐݒ�
print $img->png(); #PNG�`���ŉ摜���o�͂���

