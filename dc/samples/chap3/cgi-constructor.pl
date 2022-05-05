#!/usr/bin/perl
use CGI;                #CGIモジュールのインポート
$cgi = new CGI;         #CGIオブジェクトの生成
print $cgi->header;     #ヘッダ出力
print $cgi->start_html; #HTML開始タグ出力
print $cgi->end_html;   #HTML終了タグ出力
