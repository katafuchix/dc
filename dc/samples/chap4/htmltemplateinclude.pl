#!/usr/bin/perl
print "Content-type: text/html; charset=shift-jis\n\n";
use HTML::Template;
#�e���v���[�g�������`�Btmpl_if�^tmpl_else�^tmpl_unless�^�O���g�p���A
#flag�p�����[�^�̒l�ŏo�͂��镶�����ύX����
$string = <<EOL
<html>
  <body>
     test
     <tmpl_include name="template-footer.tmpl">
  </body>
</html>
EOL
;
$template = HTML::Template->new_scalar_ref(\$string);
#�e���v���[�g�𕶎��񂩂�ǂݍ���
$template->param(footer => "�t�b�^�[�e���v���[�g"); #flag��1��ݒ�
print $template->output(); #�e���v���[�g���o��
