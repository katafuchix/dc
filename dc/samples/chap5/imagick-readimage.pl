#!/usr/bin/perl
print "Content-type: image/jpeg\n\n";

use Image::Magick;
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̐���
$image->Set(size=>"200x160");          # 200x160�̃L�����o�X���쐬
$image ->ReadImage('xc:pink');         # �w�i�F���s���N�̋�摜��ǂݍ���
# �l�p�`��`��
$image->Draw(primitive=>'rectangle', points=>"50,50 150,110",
             stroke=>'blue', fill=>'red');
binmode STDOUT;
$image->Write('jpeg:-');
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
