#!/usr/local/bin/perl
use Template;                    # テンプレートモジュールの読込
my $template = Template->new();  # テンプレートオブジェクトの作成
my $vars = { val =>  10};
$template->process(              # テンプレートに出力
      'ttk-if.tpl',$vars,$output
   ) or print Template->error();
print $output;
#結果例
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>if/elseif/else/unless</title>
#</head>
#<body bgcolor="#ffffff">
#"value is greater than 5";<br>
#"value is greater than 0";<br>
# "value is not greater than 100";<br>
#"value is greater than 100";
#<!-- フッターを読み込み-->
#</body>
#</html>
