#!/usr/local/bin/perl
use Template;                    # �e���v���[�g���W���[���̓Ǎ�
my $template = Template->new();  # �e���v���[�g�I�u�W�F�N�g�̍쐬
my $vars = {                     # �e���v���[�g�ɕ\������l���i�[
       message  => "Hello World"
};
$template->process(              # �e���v���[�g�ɏo��
      'ttk-new.tpl',$vars
   );
# ���ʗ�
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>sample</title>
#</head>
#
#<body bgcolor="#ffffff">
#<!-- �^�C�g����"sample"�Ƃ��ăw�b�_�[��ǂݍ���-->
#Hello World<!-- Hello World��\��-->
#<!-- �t�b�^�[��ǂݍ���-->
#</body>
#</html>
