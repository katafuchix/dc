#!/usr/local/bin/perl
use Template;                    # テンプレートモジュールの読込
my $template = Template->new();  # テンプレートオブジェクトの作成
my $vars = { };
$template->process(              # テンプレートに出力
      'ttk-wrapper.tpl',$vars,$output
   ) or print Template->error();
print $output;
#結果例
#<html>
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>wrapper</title>
#</head>
#<body bgcolor="#ffffff">
#<!-- ブロックをラッパー -->
#<b><i>Hello World !!</i></b>
#<!-- フッターを読み込み-->
#</body>
#</html>
