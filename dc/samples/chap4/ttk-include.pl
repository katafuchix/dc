#!/usr/local/bin/perl
use Template;                    # �e���v���[�g���W���[���̓Ǎ�
my $template = Template->new();  # �e���v���[�g�I�u�W�F�N�g�̍쐬
my $vars = {
    message        => "HelloWorld!!",           # �X�J���[
    };
$template->process(              # �e���v���[�g�ɏo��
      'ttk-include.tpl',$vars,$output
   ) or print Template->error();
print $output;
#���ʗ�
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>include</title>
#</head>
#<body bgcolor="#ffffff">
#<!-- �v���O�������Ŋi�[�����ϐ��\�� -->
#HelloWorld!!<br>
#<!-- �O���t�@�C���̓ǂݍ��� -->
#insert:[% message %]<br>
#<!-- �O���e���v���[�g�̓ǂݍ��� -->
#include:HelloWorld!!<br>include:HelloWorld!!<br>
#<!-- �t�b�^�[��ǂݍ���-->
#</body>
#</html>
