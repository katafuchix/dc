print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image1 = Image::Magick->new;        # �摜�I�u�W�F�N�g�̐���
$image1 ->Read('sample1.JPG');       # ���摜�i200x150�j��ǂݍ���
$image2 = Image::Magick->new;        # ��������摜��ǂݍ���
$image2 ->Read('sample2.JPG');
$image2->Resize(width=>100, height=>100); # ��������摜�̃T�C�Y�ύX
# �摜��Src�����ō�������
$image1->Composite(image=>$image2, compose=>'Src', gravity=>'Center');
binmode STDOUT;
$image1->Write('jpeg:-');            # �摜��JPEG�ŏo��
undef $image1;                       # �摜�I�u�W�F�N�g��j�����ă��������J��
undef $image2;
exit;
