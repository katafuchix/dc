print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̐���
$image->Set(size=>"200x160");          # 200x160�̃L�����o�X���쐬
$image->ReadImage("xc:white");         # �w�i�����̉摜��ݒ�
#(0,5)�ɐ̓_��`��
$image->Draw(primitive=>'point', points=>'100,5', fill=>'blue');
#(0,10)����i200,10�j�ɐ̐���`��
$image->Draw(primitive=>'line', points=>'0,10 200,10', stroke=>'blue');
#(10,20)����(190,30)�ɐ̗֊s�ŐԂ��h��Ԃ����l�p�`��`��
$image->Draw(primitive=>'rectangle', points=>"10,20 190,30",
             stroke=>'blue', fill=>'red');
#���S�_��(100,50)�Ƃ��āA�c����20�s�N�Z���A����180�s�N�Z���̑ȉ~��`��
$image->Draw(primitive=>'ellipse', points=>"100,50 90,10 0,360"
           , stroke=>'brown',fill => "pink");
#���S�_��(100,80)�Ƃ��āA(100,90)��ʂ���~��`���i���a10�s�N�Z���j
$image->Draw(primitive=>'circle', points=>"100,80 100,90", stroke=>'blue');
#(0,100) (50,120) (100,100) (150,120) (200,100)��ʂ�܂����`��
$image->Draw(primitive=>'polyline',
             points=>"0,100 50,120 100,100 150,120 200,100");
#(10,130) (10,150) (190,130) (190,150)�����ɒʂ鑽�p�`��`��
$image->Draw(primitive=>'polygon', points=>"10,130 10,150 190,130 190,150 ");
#���E���܂�(50,80)����_�Ƃ��ĉ��F�ŃL�����o�X��h��Ԃ�
$image->Draw(primitive=>'color', points=>'50,80',
             method=>'Floodfill',fill=>'yellow');
binmode STDOUT;
$image->Write('jpeg:-');               # �摜��JPEG�ŏo��
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
