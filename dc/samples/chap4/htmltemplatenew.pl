#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::Template;
$string = '<html><body><tmpl_var name="test"></body></html>';
#�e���v���[�g�𕶎��񂩂�ǂݍ���
$template = HTML::Template->new_scalar_ref(\$string);
$template->param("test" => "template test"); #�������body�^�O�ɖ��ߍ���
#��������o��
print $template->output; #���ʁF<html><body>template test</body></html>
print "</PRE></BODY></HTML>";
