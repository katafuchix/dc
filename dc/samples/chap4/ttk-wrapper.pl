#!/usr/local/bin/perl
use Template;                    # �e���v���[�g���W���[���̓Ǎ�
my $template = Template->new();  # �e���v���[�g�I�u�W�F�N�g�̍쐬
my $vars = { };
$template->process(              # �e���v���[�g�ɏo��
      'ttk-wrapper.tpl',$vars,$output
   ) or print Template->error();
print $output;
#���ʗ�
#<html>
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>wrapper</title>
#</head>
#<body bgcolor="#ffffff">
#<!-- �u���b�N�����b�p�[ -->
#<b><i>Hello World !!</i></b>
#<!-- �t�b�^�[��ǂݍ���-->
#</body>
#</html>
