#print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image1 = Image::Magick->new;        # �摜�I�u�W�F�N�g�̐���
#$image1 ->Read('sample1.JPG');       # ���摜�i200x160�j��ǂݍ���
$image1 ->Read('kamon.gif');
$image2 = Image::Magick->new;        # ��������摜��ǂݍ���
#$image2 ->Read('sample2.JPG');
$image2 ->Read('moji1.gif');
#$image2->Resize(width=>100, height=>100); # ��������摜�̃T�C�Y�ύX
# �摜��Over�����ō�������
$image1->Composite(image=>$image2, compose=>'Over', gravity=>'Center');
binmode STDOUT;
#$image1->Write('jpeg:-');            # �摜��JPEG�ŏo��
$image1->Write('textanime1.gif');



$image3 = Image::Magick->new;        # �摜�I�u�W�F�N�g�̐���
#$image1 ->Read('sample1.JPG');       # ���摜�i200x160�j��ǂݍ���
$image3 ->Read('kamon.gif');
$image4 = Image::Magick->new;        # ��������摜��ǂݍ���
#$image2 ->Read('sample2.JPG');
$image4 ->Read('moji2.gif');
#$image4->Resize(width=>100, height=>100); # ��������摜�̃T�C�Y�ύX
# �摜��Over�����ō�������
$image3->Composite(image=>$image4, compose=>'Over', gravity=>'Center');
binmode STDOUT;
#$image1->Write('jpeg:-');            # �摜��JPEG�ŏo��
$image3->Write('textanime2.gif');


# �I�u�W�F�N�g�쐬
my $image = Image::Magick->new;
# �摜�ǂݍ���
$image->Read(qw(textanime1.gif textanime2.gif));
#$image->Read(qw($image1->Write('jpeg:-') $image3->Write('jpeg:-')));


#$image->Set(loop=>0);
$image->Set(loop=>0);
$image->Set(dispose=>2);

$image->Set(delay=>50);


binmode STDOUT;
$image->Write('kamonanime.gif');



undef $image1;                       # �摜�I�u�W�F�N�g��j�����ă��������J��
undef $image2;
exit;