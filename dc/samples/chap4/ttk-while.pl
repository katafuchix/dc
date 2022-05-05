#!/usr/local/bin/perl
use Template;                    # �e���v���[�g���W���[���̓Ǎ�
my $template = Template->new();  # �e���v���[�g�I�u�W�F�N�g�̍쐬
my $vars = {
    list_value => [1..10],                      # �z��
    list_data  => ["one","two","three"],        # �z��
};
$template->process(              # �e���v���[�g�ɏo��
      'ttk-while.tpl',$vars,$output
   ) or print Template->error();
print $output;
#���ʗ�
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>loop</title>
#</head>
#
#<body bgcolor="#ffffff">
#<!-- WHILE�^�O -->
#1,2,3,4,5,6,7,8,9,10,
#<br>
#<!-- FOREACH�^�O -->
#1,2,3,4,5,6,7,8,9,10,
#<br>
#<!-- NEXT�^�O -->
#1,2,3,4,6,7,8,9,10,
#<br>
#<!-- LAST�^�O -->
#1,2,3,4,
#<!-- �t�b�^�[��ǂݍ���-->
#</body>
#</html>