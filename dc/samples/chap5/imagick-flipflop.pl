print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');          # �摜��ǂݍ���
$image ->Flip();                       # �㉺���]����
$image ->Flop();                       # ���E���]����
#���̎��_�ŉ摜�͏㉺���E�Ƃ��ɔ��]���Ă���
binmode STDOUT;
$image->Write('jpeg:-');               # �摜��JPEG�ŏo��
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
