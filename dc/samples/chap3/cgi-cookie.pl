#!/usr/bin/perl
use CGI;                                   #CGIモジュール呼び出し
$query = new CGI();
$cookie = $query->cookie(-name=>'count',   #クッキー作成
                 -value=>0,                #値は0
                 -path => "/cgiperl/",     #/cgiperl/パスで有効
                 -expires => "+5h"         #5時間有効
                         );                #'count'クッキーを作成
print $query->header(-cookie=>$cookie);    #クッキーを出力する
print $query->start_html();                #HTML開始
print $value;                              #クッキーの値を出力。結果：1,2,3,4,5...
print $query->end_html();                  #HTML終了
