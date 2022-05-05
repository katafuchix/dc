#!/usr/bin/perl
use CGI;                                   #CGIモジュール呼び出し
$query = new CGI();
$uploadCookie = $ENV{'HTTP_COOKIE'};       #クッキー文字列取得
($name,$value) = split(/=/,$uploadCookie); #クッキーの名前と値を取得
if($name eq 'count'){                      #'count'という名前のクッキーなら
  $value ++;                               #値を1増やす
}else{                                     #それ以外なら（最初の訪問なら）
  $value = 1;                              #値を1に初期化
}
$cookie = $query->cookie(-name=>'count',   #クッキーを作成するメソッド
                 -value=>$value);          #'count'クッキーを作成
print $query->header(-cookie=>$cookie);    #クッキーを出力する
print $query->start_html();                #HTML開始
print $value;                              #クッキーの値を出力。結果：1,2,3,4,5...
print $query->end_html();                  #HTML終了
