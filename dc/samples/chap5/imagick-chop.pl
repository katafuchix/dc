print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;        # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');       # �摜�i200x160�j��ǂݍ���
# (100,50)����c��100�A����100�̗̈��؂�o��
$image->Chop(width=>30,height=>30, x=>100, y=>50);
#$image->Chop(geometry=>'30x30',x=>100, y=>50 );
binmode STDOUT;
$image->Write('jpeg:-');            # �摜��JPEG�ŏo��
undef $image;                       # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
