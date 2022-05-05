#!/usr/local/bin/perl
use Template;                    # テンプレートモジュールの読込
my $template = Template->new({   # テンプレートオブジェクトの作成
                              EVAL_PERL => 1
                             });
my $vars = {
             message =>  "Hello World !!" # スカラー
            };
$template->process(              # テンプレートに出力
      'ttk-perl.tpl',$vars,$output
   ) or print Template->error();
print $output;
#結果例
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>perl</title>
#</head>
#
#<body bgcolor="#ffffff">
#perl:Hello World !!<br>
#10<br>
#raw perl:Hello World !!<br>
#<!-- フッターを読み込み-->
#</body>
#</html>