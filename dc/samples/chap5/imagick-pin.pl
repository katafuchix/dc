print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��
use Image::Magick;
$image = Image::Magick->new;              # �摜�I�u�W�F�N�g�̐���
# Ping���\�b�h�ŉ摜(200x150�T�C�Y)�̏����擾����
($p_width, $p_height, $p_size, $p_format) = $image ->Ping('sample1.JPG');
$image ->Read('sample1.JPG');             # �摜�i200x150�T�C�Y�j��ǂݍ���
($g_width, $g_height, $g_size, $g_format) # Get���\�b�h�ő����l���擾����
     = $image->Get('width', 'height', 'filesize', 'magick');
print "Ping�Ŏ擾�F".$p_width.",".$p_height.",".$p_size.",".$p_format."|";
print "Get�Ŏ擾 �F".$g_width.",".$g_height.",".$g_size.",".$g_format;
#���ʁFPing�Ŏ擾�F200,150,7917,JPEG | Get�Ŏ擾 �F200,150,7917,JPEG
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��

print "</body></html>";
