print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;        # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');       # �摜�i200x160�j��ǂݍ���
#�摜�����v����45�x��]�����A�w�i�𐅐F�ɐݒ肷��
$image ->Rotate(degrees => 45 , color => 'cyan');
binmode STDOUT;
$image->Write('jpeg:-');            # �摜��JPEG�ŏo��
undef $image;                       # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
