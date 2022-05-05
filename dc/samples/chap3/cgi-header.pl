#!/usr/bin/perl
use CGI;                #CGIモジュールのインポート
$cgi = new CGI;         #CGIオブジェクトの生成
print $cgi->header(-type=>'text/html', #ヘッダ出力 コンテントタイプ指定
                   -status=>'200 OK',  #ステータスコード指定
                   -expires=>'+20m',   #有効期限20分後
                   -charset=>'shift-jis', #文字コードはShift-JIS
                   -unknown => 'unknown header', #未定義の引数
                   -cookie=>'cookie-string'); #クッキー文字列指定
                        #本来は固定ではなく何らかのルールで文字列を生成する
