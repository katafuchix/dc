print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');          # �摜��ǂݍ���
$image ->Roll(x=>100,y=>50);           # x������100�Ay������50���炷
#$image -> Roll(geometry=>'+100+50');  # geometry���g���Ă��炷�ꍇ
binmode STDOUT;
$image->Write('jpeg:-');               # �摜��JPEG�ŏo��
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
