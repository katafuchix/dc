#!/usr/local/bin/perl
use Template;                    # �e���v���[�g���W���[���̓Ǎ�
my $template = Template->new();  # �e���v���[�g�I�u�W�F�N�g�̍쐬
my $vars = { val =>  10};
$template->process(              # �e���v���[�g�ɏo��
      'ttk-if.tpl',$vars,$output
   ) or print Template->error();
print $output;
#���ʗ�
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>if/elseif/else/unless</title>
#</head>
#<body bgcolor="#ffffff">
#"value is greater than 5";<br>
#"value is greater than 0";<br>
# "value is not greater than 100";<br>
#"value is greater than 100";
#<!-- �t�b�^�[��ǂݍ���-->
#</body>
#</html>
