print "Content-type: image/gif\n\n";

use Image::Magick;
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.PNG');          # gif�摜�i200x160�T�C�Y�j��ǂݍ���
$image->Draw(primitive=>'circle', points=>"100,75 180,75", #�Ԃ��~��`��
                                  strokewidth => 20 , stroke=>'red');
$image->Transparent(color=>"red");     # �Ԃ𓧉߂���
binmode STDOUT;
$image->Write('gif:-');
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
