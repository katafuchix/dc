#!/usr/bin/perl
print "Content-type: image/jpeg\n\n";

use Image::Magick;
$image = Image::Magick->new;            # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.jpg');           # �摜�i200x160�T�C�Y�j��ǂݍ���
$image ->AddNoise(noise => 'Impulse' ); # �m�C�Y��ǉ�
binmode STDOUT;
$image->Write('jpeg:-');                # �摜��JPEG�ŏo��
undef $image;                           # �摜�I�u�W�F�N�g��j�����ă��������J��

exit;