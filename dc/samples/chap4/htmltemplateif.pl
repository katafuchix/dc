#!/usr/bin/perl
print "Content-type: text/html; charset=shift-jis\n\n";
use HTML::Template;
#テンプレート文字列定義。tmpl_if／tmpl_else／tmpl_unlessタグを使用し、
#flagパラメータの値で出力する文字列を変更する
$string = <<EOL
<html>
  <body>
     <tmpl_if name="flag">
       if sample
     <tmpl_else>
       else sample
     </tmpl_if>
     <tmpl_unless name="flag">
       unless sample
     <tmpl_else>
       else sample
     </tmpl_unless>
  </body>
</html>
EOL
;
$template = HTML::Template->new_scalar_ref(\$string);
#テンプレートを文字列から読み込む
$template->param(flag => 1); #flagに1を設定
print $template->output(); #テンプレートを出力
