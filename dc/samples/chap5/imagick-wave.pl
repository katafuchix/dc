print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;        # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');       # �摜�i200x160�j��ǂݍ���
#�c����8�A������5�̔g�ŃE�F�[�u���ʂ�����
$image ->Wave(amplitude => 8 , wavelength => 5);
#$image ->Wave(geometry => '8x5');  # geometry�������g���ăE�F�[�u���ʂ�����
binmode STDOUT;
$image->Write('jpeg:-');            # �摜��JPEG�ŏo��
undef $image;                       # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
