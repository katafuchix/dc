print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;        # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');       # �摜�i200x160�j��ǂݍ���
# (30,30)����c��100�A����100�̗̈��؂�o��
$image->Crop(width=>100,height=>100, x=>30, y=>30 );
#$image->Crop(geometry=>'100x100',x=>30, y=>30 );
binmode STDOUT;
$image->Write('jpeg:-');            # �摜��JPEG�ŏo��
undef $image;                       # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
