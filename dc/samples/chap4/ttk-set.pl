#!/usr/local/bin/perl
use Template; # �e���v���[�g���W���[���̓Ǎ�
my $template = Template->new(); # �R���X�g���N�^
my $vars = {
message => "HelloWorld!!", # �X�J���[
};
$template->process( # �e���v���[�g�ɏo��
"ttk-set.tpl",$vars,$output
) or print Template->error();
print $output;
#���ʁF
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>set</title>
#</head>
#<body bgcolor="#ffffff">
#<!-- �^�C�g����"set"�Ƃ��ăw�b�_�[��Ǎ���-->
#
#<!-- �v���O�������Ŋi�[�����ϐ��\��-->
#<font size ="-1" color="#0000FF">HelloWorld!!</font><br>
#<!-- �e���v���[�g���Ŋi�[�����ϐ��\��-->
#HelloWorld!!<br>
#message is $val<br>
#message is HelloWorld!!<br>
#HelloWorld!!<br>
#1 + 2 * 3
# = 7<br>
#HelloWorld!!<br>
#<!-- �f�t�H���g���㏑��-->
#
#<font size=+1 color="#0000FF">HelloWorld!!</font><br>
#<!-- �t�b�^�[�̓Ǎ���-->
#</body>
#</html>
