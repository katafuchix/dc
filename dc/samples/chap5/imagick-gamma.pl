print "Content-type: image/jpeg\n\n";

use Image::Magick;
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');          # �摜�i200x160�T�C�Y�j��ǂݍ���
$image ->Gamma( gamma => 5);           # �K���}�␳���s��
binmode STDOUT;
$image->Write('jpeg:-');               # �摜��JPEG�ŏo��
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
