#!/usr/local/bin/perl
use Template;                    # �e���v���[�g���W���[���̓Ǎ�
# �e���v���[�g�I�u�W�F�N�g�̍쐬
my $template = Template->new();
my $vars = {
             message =>  "Hello World !!" # �X�J���[
            };
$template->process(              # �e���v���[�g�ɏo��
      'ttk-macro.tpl',$vars
   ) or print Template->error();
#���ʗ�
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>macro</title>
#</head>
#<body bgcolor="#ffffff">
#<b>Hello World !! </b>
#<br>
#12<br>
# value is not 10
#<br>
#<!-- �t�b�^�[��ǂݍ���-->
#</body>
#</html>