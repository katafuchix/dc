#!/user/bin/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��

use GD;
$img = new GD::Image(100,100);    # �V�����C���[�W���쐬
$img->trueColor(1);    # 24�r�b�g�̐F�f�[�^���g���ݒ�ɕύX
$img->trueColor(0);    # 8�r�b�g�̐F�f�[�^���g���ݒ�ɖ߂�
$white = $img->colorAllocate(255,255,255); # ���F��ݒ�
$red   = $img->colorAllocate(255,0,0); # �ԐF��ݒ�
$black = $img->colorAllocate(0,0,0); # ���F��ݒ�
$img->rectangle(0,0,99,99,$black); # ���̐����`��`��
$img->arc(50,50,50,50,0,360,$red); # �Ԃ��~��`��
$img->fill(50,50,$red); # �ȉ~��Ԃœh��
binmode STDOUT; # �o�C�i���E�X�g���[���֏������ނ��Ƃ��m���ɂ���
print $img->png;# �摜��PNG�`���ŏo�͂���

