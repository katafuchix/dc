#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::Template;
$string = '<html><body><tmpl_var name="test"></body></html>';
#テンプレートを文字列から読み込む
$template = HTML::Template->new_scalar_ref(\$string);
$template->param("test" => "template test"); #文字列をbodyタグに埋め込む
#文字列を出力
print $template->output; #結果：<html><body>template test</body></html>
print "</PRE></BODY></HTML>";
