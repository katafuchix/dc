print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');          # �摜�i200x150�T�C�Y�j��ǂݍ���
# width,height���w�肵�ĉ摜��400x300�Ƀ��T�C�Y����Box�t�B���^�[�łڂ���
$image ->Resize(width => 400 , height => 300 , blur =>3);
# geometry���w�肵��400x300�Ƀ��T�C�Y����
#$image ->Resize(geometry => (400,300) , blur => 3 );
binmode STDOUT;
$image->Write('jpeg:-');               # �摜��JPEG�ŏo��
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
