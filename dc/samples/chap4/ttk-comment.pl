#!/usr/local/bin/perl
use Template; # �e���v���[�g���W���[���̓Ǎ�
my $template = Template->new(); # �R���X�g���N�^
my $vars = { # �e���v���[�g�ŗ��p����p�����[�^���i�[
message => "Hello World"
};
$template->process( # �e���v���[�g�Ƀp�����[�^�����蓖�Ă�
"ttk-comment.tpl",$vars
);
# ���ʗ�
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>comment</title>
#</head>
#<body bgcolor="#ffffff">
#<!-- �^�C�g����"comment"�Ƃ��ăw�b�_�[��Ǎ���-->
#Hello World
#<!-- �����ɂ̓R�����g�^�O�������Ă��邪�\������Ȃ�-->
#<!-- �t�b�^�[�̓Ǎ���-->
#</body>
#</html>