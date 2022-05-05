#!/usr/local/bin/perl
use Template;                    # �e���v���[�g���W���[���̓Ǎ�
use CGI;                         # CGI���W���[���̓Ǎ�
my $template = Template->new();  # �e���v���[�g�I�u�W�F�N�g�̍쐬
my $vars = {
    message        => "HelloWorld!!",                      # �X�J���[�i������j
    num_1          => 5,                                   # �X�J���[�i���l�j
    num_2          => 7,
    array_value    => ["Hello","World","!!"],              # �z��
    hash_value     => {                                    # �n�b�V��
                           "hello" => "Hello",
                           "world" => "World",
                           "ex"    => "!!",
                         },
	sub_value  => sub { return join('', 'Hello', @_) },     # �֐�
    # �I�u�W�F�N�g�Ƃ���CGI�I�u�W�F�N�g��n��
	obj_value  => CGI->new('message=HelloWorld!!&debug=1'),
    };
$template->process(              # �e���v���[�g�ɏo��
      'ttk-variable.tpl',$vars,$output
   ) or print Template->error();
print $output;
# ���ʗ�
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>process</title>
#</head>
#
#<body bgcolor="#ffffff">
#<!-- �^�C�g����"process"�Ƃ��ăw�b�_�[��ǂݍ���-->
#<!-- �X�J���[�ϐ��\��-->
#val:HelloWorld!!<br>
#<!-- ���l�v�Z-->
#num:5+7=12<br>
#<!-- �z��\��-->
#array:HelloWorld!!<br>
#<!-- �n�b�V���\��-->
#hash:HelloWorld!!<br>
#<!-- �֐��\��-->
#sub:HelloWorld!!<br>
#<!-- �I�u�W�F�N�g�\��-->
#obj:HelloWorld!!
#<!-- �t�b�^�[��ǂݍ���-->
#</body>
#</html>
