#!/usr/local/bin/perl
use Template;                    # �e���v���[�g���W���[���̓Ǎ�
my $template = Template->new();  # �e���v���[�g�I�u�W�F�N�g�̍쐬
my $vars = {
             list_value =>  [1..5] # �z��
            };
$template->process(              # �e���v���[�g�ɏo��
      'ttk-switch.tpl',$vars,$output
   ) or print Template->error();
print $output;
#���ʗ�
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>switch</title>
#</head>
#
#<body bgcolor="#ffffff">
# value is  1
#<br>
# value is 2 or 3
#<br>
# value is 2 or 3
#<br>
#  value is 4
#<br>
# value is not 10
#<br>
#<!-- �t�b�^�[��ǂݍ���-->
#</body>
#</html>