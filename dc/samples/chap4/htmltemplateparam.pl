#!/usr/bin/perl
print "Content-type: text/html\n\n";
use HTML::Template;
#�e���v���[�g�������`
$string = <<EOL
<html>
  <body>
    <tmpl_var name="bodytext">
  </body>
</html>
EOL
;
$template = HTML::Template->new_scalar_ref(\$string);
#�e���v���[�g�𕶎��񂩂�ǂݍ���
$template->param(bodytext => "Test Body",); #�p�����[�^�ɒl��ݒ�
print $template->output();                    #���ʏo��
$template->clear_params();                  #�p�����[�^�����ׂď�����
print $template->output();                    #���ʏo��
