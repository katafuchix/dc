#!/usr/local/bin/perl
use Template;                    # テンプレートモジュールの読込
my $template = Template->new();  # テンプレートオブジェクトの作成
my $vars = {
             list_value => [1..5] # 配列
            };
$template->process(              # テンプレートに出力
      'ttk-try.tpl',$vars,$output
   ) or print Template->error();
print $output;
#結果例
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>try</title>
#</head>
#
#<body bgcolor="#ffffff">
#
#error ! : message val is 1 : error_type:error_1| process 1
#<br>
#error !! : message  val is 2 : error_type:error_2| process 2
#<br>
#error !!! : message val is 3 : error_type:error_10| process 3
#<br>
# success !! val is 4   | process 4
#<br>
# success !! val is 5   | process 5
#<br>
#<!-- フッターを読み込み-->
#</body>
#</html>