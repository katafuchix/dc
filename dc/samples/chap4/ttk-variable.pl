#!/usr/local/bin/perl
use Template;                    # テンプレートモジュールの読込
use CGI;                         # CGIモジュールの読込
my $template = Template->new();  # テンプレートオブジェクトの作成
my $vars = {
    message        => "HelloWorld!!",                      # スカラー（文字列）
    num_1          => 5,                                   # スカラー（数値）
    num_2          => 7,
    array_value    => ["Hello","World","!!"],              # 配列
    hash_value     => {                                    # ハッシュ
                           "hello" => "Hello",
                           "world" => "World",
                           "ex"    => "!!",
                         },
	sub_value  => sub { return join('', 'Hello', @_) },     # 関数
    # オブジェクトとしてCGIオブジェクトを渡す
	obj_value  => CGI->new('message=HelloWorld!!&debug=1'),
    };
$template->process(              # テンプレートに出力
      'ttk-variable.tpl',$vars,$output
   ) or print Template->error();
print $output;
# 結果例
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>process</title>
#</head>
#
#<body bgcolor="#ffffff">
#<!-- タイトルを"process"としてヘッダーを読み込み-->
#<!-- スカラー変数表示-->
#val:HelloWorld!!<br>
#<!-- 数値計算-->
#num:5+7=12<br>
#<!-- 配列表示-->
#array:HelloWorld!!<br>
#<!-- ハッシュ表示-->
#hash:HelloWorld!!<br>
#<!-- 関数表示-->
#sub:HelloWorld!!<br>
#<!-- オブジェクト表示-->
#obj:HelloWorld!!
#<!-- フッターを読み込み-->
#</body>
#</html>
