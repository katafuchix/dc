print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̐���
$image ->Read('sample1.JPG');          # �摜�i200x160�j��ǂݍ���
# �c��20�A����20�̕��ʓI�ȐԂ��g��ǉ�����B�T�C�Y��220x180�ɂȂ�
$image ->Border(width=>20, height=>20, fill=>'red');
# �c��10�A����10�̗��̓I�ȐԂ��g��ǉ�����B�T�C�Y��220x180�ɂȂ�
# $image ->Frame(width=>20, height=>20, outer => 10 ,inner => 10,fill=>'red');
# �c��10�A����10�ɖ��Â�t���摜�𕂂��グ��
$image ->Raise(width=>10, height=>10,raise => true);
binmode STDOUT;
$image->Write('jpeg:-');               # �摜��JPEG�ŏo��
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
