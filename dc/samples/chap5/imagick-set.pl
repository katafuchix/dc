print "Content-type: image/jpeg\n\n";

use Image::Magick;
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̍쐬
$image->Set(size=>"200x200");          # 200x200�̃L�����o�X���쐬
$image ->ReadImage('xc:white');        # �w�i�F�����̋�摜��ǂݍ���
#�~��`��
$image->Draw(primitive=>'circle', points=>"100,100 150,150", stroke=>'blue');
binmode STDOUT;
$image->Write('jpeg:-');               # �摜��JPEG�ŏo��
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă����������
exit;
