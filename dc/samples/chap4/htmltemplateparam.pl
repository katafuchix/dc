#!/usr/bin/perl
print "Content-type: text/html\n\n";
use HTML::Template;
#テンプレート文字列定義
$string = <<EOL
<html>
  <body>
    <tmpl_var name="bodytext">
  </body>
</html>
EOL
;
$template = HTML::Template->new_scalar_ref(\$string);
#テンプレートを文字列から読み込む
$template->param(bodytext => "Test Body",); #パラメータに値を設定
print $template->output();                    #結果出力
$template->clear_params();                  #パラメータをすべて初期化
print $template->output();                    #結果出力
