#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@list = (1,2,3,4,5);  #配列変数
$reflist = \@list;    #リファレンスをスカラ変数に代入
print $reflist->[2];  #アロー演算子で要素にアクセス。結果：3
print "\n";
%hash = ("Sunday" => "日","Monday" => "月","Tuesday"=>"火"); #連想配列変数
$refhash = \%hash;           #リファレンスをスカラ変数に代入
print $refhash->{"Monday"};  #アロー演算子で値を参照。結果：月
print "\n";
use CGI;              #CGIオブジェクト定義読み込み
$cgi = new CGI;       #CGIオブジェクト生成
print $cgi->header;   #リファレンスからheaderメソッドを呼び出す。
#結果：Content-Type: text/html; charset=ISO-8859-1
print "</PRE></BODY></HTML>";
