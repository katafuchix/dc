#!/usr/local/bin/perl
use Template;                    # テンプレートモジュールの読込
my $template = Template->new();  # テンプレートオブジェクトの作成
my $vars = {
    message        => "HelloWorld!!",           # スカラー
    };
$template->process(              # テンプレートに出力
      'ttk-block.tpl',$vars,$output
   ) or print Template->error();
print $output;
#結果例
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>include</title>
#</head>
#
#<body bgcolor="#ffffff">
#
#<!-- ブロックの読み込み -->
#block1:HelloWorld!!<br>
#
#
#block2:HelloWorld!!<br>
#
#<!-- フッターを読み込み-->
#</body>
#</html>
