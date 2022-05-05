#!/usr/local/bin/perl
use Template; # テンプレートモジュールの読込
my $template = Template->new(); # コンストラクタ
my $vars = {
message => "HelloWorld!!", # スカラー
};
$template->process( # テンプレートに出力
"ttk-set.tpl",$vars,$output
) or print Template->error();
print $output;
#結果：
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>set</title>
#</head>
#<body bgcolor="#ffffff">
#<!-- タイトルを"set"としてヘッダーを読込む-->
#
#<!-- プログラム側で格納した変数表示-->
#<font size ="-1" color="#0000FF">HelloWorld!!</font><br>
#<!-- テンプレート側で格納した変数表示-->
#HelloWorld!!<br>
#message is $val<br>
#message is HelloWorld!!<br>
#HelloWorld!!<br>
#1 + 2 * 3
# = 7<br>
#HelloWorld!!<br>
#<!-- デフォルトを上書き-->
#
#<font size=+1 color="#0000FF">HelloWorld!!</font><br>
#<!-- フッターの読込み-->
#</body>
#</html>
