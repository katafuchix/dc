print "Content-type: image/jpeg\n\n";

use Image::Magick;
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');          # �摜�i200x160�T�C�Y�j��ǂݍ���
$image->Swirl( degrees=>180);          # �摜�𒆐S���玞�v������180�x�˂���
binmode STDOUT;
$image->Write('jpeg:-');               # �摜��JPEG�ŏo��
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
