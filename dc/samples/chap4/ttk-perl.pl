#!/usr/local/bin/perl
use Template;                    # �e���v���[�g���W���[���̓Ǎ�
my $template = Template->new({   # �e���v���[�g�I�u�W�F�N�g�̍쐬
                              EVAL_PERL => 1
                             });
my $vars = {
             message =>  "Hello World !!" # �X�J���[
            };
$template->process(              # �e���v���[�g�ɏo��
      'ttk-perl.tpl',$vars,$output
   ) or print Template->error();
print $output;
#���ʗ�
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>perl</title>
#</head>
#
#<body bgcolor="#ffffff">
#perl:Hello World !!<br>
#10<br>
#raw perl:Hello World !!<br>
#<!-- �t�b�^�[��ǂݍ���-->
#</body>
#</html>