print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;        # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');       # �摜�i200x160�j��ǂݍ���
$image ->OilPaint(radius=>2);       # �摜�ɖ��G���ʂ�����
binmode STDOUT;
$image->Write('jpeg:-');            # �摜��JPEG�ŏo��
undef $image;                       # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
