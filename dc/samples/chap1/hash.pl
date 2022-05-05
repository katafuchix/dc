#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
%hash = ("Sunday"=>"日",   #連想配列変数の初期化
         "Monday"=>"月",   #キーに文字列を使用
         "Tuesday"=>"火");
%hash2 = (0,"日",          #別の初期化方法
          1.2,"月",        #キーに数値を使用
          2,"火");
print scalar %hash;        #要素数、領域サイズを出力。結果：3/8
print "\n";
print $hash{"Sunday"};     #キー"Sunday"の値を出力。結果：日
print "\n";
print $hash2{0};           #キー0の値を出力。結果：日
print "\n";
print $hash2{1.2};         #キー1.2の値を出力。結果：月
$hash{"Monday"} = "月曜日";#キー"Monday"の値を変更
print "\n";
foreach $key(keys %hash){  #連想配列のキーを順に$keyに代入。よく使われるパターン
  print $key;              #連想配列のキーと値を順に出力
  print $hash{$key};       #結果：Tuesday 火 Sunday 日 Monday 月曜日
}
print "\n";
@list = @hash{"Sunday","Tuesday"};
#ハッシュスライスを使用し、連想配列の2つの値を取得して配列に代入
foreach $i(@list){  #配列の値を順に$iに代入
  print $i;         #値を順に出力。結果：日火
}
print "</PRE></BODY></HTML>";
