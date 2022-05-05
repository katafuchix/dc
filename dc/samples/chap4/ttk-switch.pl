#!/usr/local/bin/perl
use Template;                    # テンプレートモジュールの読込
my $template = Template->new();  # テンプレートオブジェクトの作成
my $vars = {
             list_value =>  [1..5] # 配列
            };
$template->process(              # テンプレートに出力
      'ttk-switch.tpl',$vars,$output
   ) or print Template->error();
print $output;
#結果例
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>switch</title>
#</head>
#
#<body bgcolor="#ffffff">
# value is  1
#<br>
# value is 2 or 3
#<br>
# value is 2 or 3
#<br>
#  value is 4
#<br>
# value is not 10
#<br>
#<!-- フッターを読み込み-->
#</body>
#</html>