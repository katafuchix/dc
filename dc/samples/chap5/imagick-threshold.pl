print "Content-type: image/jpeg\n\n";

use Image::Magick;
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');          # �摜�i200x160�T�C�Y�j��ǂݍ���
$image ->Threshold(threshold => '30%' );      # �P�x30%��臒l����
#$image ->BlackThreshold(threshold => '30%'); # �P�x30%�ȉ��������h��Ԃ�
#$image ->WhiteThreshold(threshold => '30%'); # �P�x30%�ȉ��𔒂��h��Ԃ�
binmode STDOUT;
$image->Write('jpeg:-');               # �摜��JPEG�ŏo��
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��

exit;
