#!/usr/local/bin/perl
use Template;                    # �e���v���[�g���W���[���̓Ǎ�
my $template = Template->new();  # �e���v���[�g�I�u�W�F�N�g�̍쐬
my $vars = {                     # �e���v���[�g�ɕ\������l���i�[
       message        => "Hello World !!",       # �X�J���[�ϐ�
       array_value    => ["Hello","World","!!"], # �z��
       hash_value     => {                       # �n�b�V��
                           "hello" => "Hello",
                           "world" => "World",
                           "ex"    => "!!",
                         }
};
$template->process(              # �e���v���[�g�ɏo��
      'ttk-process.tpl',$vars,$output
   );
print $output;
# ���ʗ�
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>process</title>
#</head>
#<body bgcolor="#ffffff">
#<!-- �^�C�g����"process"�Ƃ��ăw�b�_�[��ǂݍ���-->
#<!-- �X�J���[�ϐ��\��-->
#val:Hello World !!
#<!-- �z��\��-->
#array:Hello World !!
#<!-- �n�b�V���\��-->
#hash:Hello World !!
#<!-- �t�b�^�[��ǂݍ���-->
#</body>
#</html>