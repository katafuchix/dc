#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��

use GD;
$myImage = new GD::Image(100,100); #�o�͐�摜�I�u�W�F�N�g��ݒ�
$white = $myImage->colorAllocate(255,255,255); #����ݒ�
$black = $myImage->colorAllocate(0,0,0); #����ݒ�
$srcImage = new GD::Image(50,50); #�R�s�[���摜�I�u�W�F�N�g��ݒ�
$white = $srcImage->colorAllocate(255,255,255); #����ݒ�
$black = $srcImage->colorAllocate(0,0,0); #����ݒ�
$srcImage->rectangle(0,0,20,10,$black); #��`��`��
# $srcImage�̍��W(0,0)����25x25�s�N�Z���̗̈��
# $myImage�̍��W(50,50)�֊g��R�s�[����
$myImage->copyResized($srcImage,50,50,0,0,50,50,25,25);
# $srcImage�̍��W(0,0)����25x25 �s�N�Z���̗̈��
# $myImage�̍��W(10,10)�ɃR�s�[����i�㏑���j
$myImage->copy($srcImage,10,10,0,0,25,25);
# $myImage��90�x��]�����摜�I�u�W�F�N�g���擾
$myImage90 = $myImage->copyRotate90();
binmode STDOUT; # �o�C�i���o�͂ɐݒ�
print $myImage90->png(); #PNG�`���ŉ摜���o�͂���

