#!/usr/local/bin/perl
use Template;                    # テンプレートモジュールの読込
my $template = Template->new();  # テンプレートオブジェクトの作成
my $vars = {
    list_value => [1..10],                      # 配列
    list_data  => ["one","two","three"],        # 配列
};
$template->process(              # テンプレートに出力
      'ttk-while.tpl',$vars,$output
   ) or print Template->error();
print $output;
#結果例
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>loop</title>
#</head>
#
#<body bgcolor="#ffffff">
#<!-- WHILEタグ -->
#1,2,3,4,5,6,7,8,9,10,
#<br>
#<!-- FOREACHタグ -->
#1,2,3,4,5,6,7,8,9,10,
#<br>
#<!-- NEXTタグ -->
#1,2,3,4,6,7,8,9,10,
#<br>
#<!-- LASTタグ -->
#1,2,3,4,
#<!-- フッターを読み込み-->
#</body>
#</html>