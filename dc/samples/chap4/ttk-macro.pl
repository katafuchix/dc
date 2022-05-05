#!/usr/local/bin/perl
use Template;                    # テンプレートモジュールの読込
# テンプレートオブジェクトの作成
my $template = Template->new();
my $vars = {
             message =>  "Hello World !!" # スカラー
            };
$template->process(              # テンプレートに出力
      'ttk-macro.tpl',$vars
   ) or print Template->error();
#結果例
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>macro</title>
#</head>
#<body bgcolor="#ffffff">
#<b>Hello World !! </b>
#<br>
#12<br>
# value is not 10
#<br>
#<!-- フッターを読み込み-->
#</body>
#</html>