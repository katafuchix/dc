print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');          # �摜�i200x160�T�C�Y�j��ǂݍ���
# �x����5.0 �W���΍�0.5�̃V���[�v���ʂ�����
$image ->Sharpen( radius=>5.0, sigma=>0.5 );
# �x����5.0 �W���΍�0.5��geometry�Ŏw��
#$image ->Sharpen( geometry=>'5.0x0.5' );
binmode STDOUT;
$image->Write('jpeg:-');               # �摜��JPEG�ŏo��
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
