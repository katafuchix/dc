#!/usr/bin/perl
print "Content-type: text/html; charset=shift-jis\n\n";
use HTML::Template;
#テンプレート文字列定義。テーブルの行をループで生成するテンプレート
#__FIRST__パラメータを使用し、ループの先頭の場合はthタグを出力する
$string = <<EOL
<html>
  <body>
    <table>
      <tmpl_loop name="person">
        <tmpl_if name="__FIRST__">
        <tr>
          <th>First name</th>
          <th>Last name</th>
        </tr>
        </tmpl_if>
        <tr>
          <td><tmpl_var name="fn"></td>
          <td><tmpl_var name="ln"></td>
        </tr>
      </tmpl_loop>
    </table>
  </body>
</html>
EOL
;
$template = HTML::Template->new_scalar_ref(\$string,
                                           loop_context_vars => 1
                                           );
#loop_context_varsオプションを1に設定
#テンプレートを文字列から読み込む
$template->param(person =>  [
  { fn => "Taroh" , ln => "Yamada"},
  { fn => "Tsuyoshi" , ln => "Doi"}
  ]); #personパラメータに2つの連想配列を要素として持つ配列を設定
print $template->output(); #テンプレートを出力
