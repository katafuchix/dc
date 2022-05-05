#!/usr/local/bin/perl
use Template;                    # テンプレートモジュールの読込
my $template = Template->new();  # テンプレートオブジェクトの作成
my $vars = {                     # テンプレートに表示する値を格納
       message        => "Hello World !!",       # スカラー変数
       array_value    => ["Hello","World","!!"], # 配列
       hash_value     => {                       # ハッシュ
                           "hello" => "Hello",
                           "world" => "World",
                           "ex"    => "!!",
                         }
};
$template->process(              # テンプレートに出力
      'ttk-process.tpl',$vars,$output
   );
print $output;
# 結果例
#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
#<html>
#<head>
#<title>process</title>
#</head>
#<body bgcolor="#ffffff">
#<!-- タイトルを"process"としてヘッダーを読み込み-->
#<!-- スカラー変数表示-->
#val:Hello World !!
#<!-- 配列表示-->
#array:Hello World !!
#<!-- ハッシュ表示-->
#hash:Hello World !!
#<!-- フッターを読み込み-->
#</body>
#</html>