#!/usr/local/bin/perl
use Template; # テンプレートモジュールの読込
my $template = Template->new(); # コンストラクタ
my $vars = { # テンプレートで利用するパラメータを格納
message => "Hello World"
};
$template->process( # テンプレートにパラメータを割り当てる
"ttk-comment.tpl",$vars
);
# 結果例
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>comment</title>
#</head>
#<body bgcolor="#ffffff">
#<!-- タイトルを"comment"としてヘッダーを読込む-->
#Hello World
#<!-- ここにはコメントタグを書いているが表示されない-->
#<!-- フッターの読込み-->
#</body>
#</html>