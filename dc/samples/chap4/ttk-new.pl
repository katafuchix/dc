#!/usr/local/bin/perl
use Template;                    # テンプレートモジュールの読込
my $template = Template->new();  # テンプレートオブジェクトの作成
my $vars = {                     # テンプレートに表示する値を格納
       message  => "Hello World"
};
$template->process(              # テンプレートに出力
      'ttk-new.tpl',$vars
   );
# 結果例
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>sample</title>
#</head>
#
#<body bgcolor="#ffffff">
#<!-- タイトルを"sample"としてヘッダーを読み込み-->
#Hello World<!-- Hello Worldを表示-->
#<!-- フッターを読み込み-->
#</body>
#</html>
