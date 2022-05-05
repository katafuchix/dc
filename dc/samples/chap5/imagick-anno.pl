#!/usr/bin/perl
print "Content-type: image/jpeg\n\n";

use Image::Magick;
use Encode;
$string = "����ɂ���";
Encode::from_to ( $string , "shiftjis" , "utf8" ); #�����R�[�h��UTF-8�ɕϊ�
$font_path = "msgothic.ttc";
$image = Image::Magick->new;           # �摜�I�u�W�F�N�g�̐���
$image ->Read("sample1.JPG");          # �摜�i200x160�T�C�Y�j��ǂݍ���
$image->Annotate(                      # ��������摜�ɏ����o��
                 text=> $string,    # �����o���������ݒ�FAnnotate
                 stroke=>"red",        # ������̃A�E�g���C���̐F��ݒ�i�ԁj
                 strokewidth => 2,     # ������̃A�E�g���C���̕���ݒ�(2)
                 fill=>"white",        # �����F�̐ݒ�i���j
                 undercolor => "pink", # �w�i�F�̐ݒ�i�s���N�j
                 font=>$font_path,     # ������̃t�H���g��ݒ�imsgothic�j
                 pointsize=>"26",      # ������̃T�C�Y��ݒ�i26�j
                 x=>"150", y=>"100",   # �����񍇐��̊�_�����W�Őݒ�i150,100�j
                 antialias => true,    # �A���`�G�C���A�X
#                gravity => Center,    # �����񍇐��̊�_����p�Őݒ�i���S�j
                 align => Left,        # �����񍇐��̊�_�̊񂹕��i���񂹁j
                 rotate => 180,        # ������̉�]�p�x��ݒ�(180�x)
                 skewX=>12.5,          # �������x�����̌X�΂�ݒ�i12.5�j
                 skewY=>5.5,           # �������y�����̌X�΂�ݒ�i5.5�j
                 );
$image->Write("output2.jpg");
binmode STDOUT;
$image->Write("jpeg:-");               # �摜��JPEG�ŏo��
undef $image;                          # �摜�I�u�W�F�N�g��j�����ă��������J��
exit;
