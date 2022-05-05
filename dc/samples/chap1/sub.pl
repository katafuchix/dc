#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sub sub_a{           #引数を取らないサブルーチン
}
&sub_a;               #サブルーチン呼び出し
sub sum_3scalar($$$){    #3つのスカラを引数として受け取るサブルーチン
  #引数は@_に入っているので、$_[0]で0番目の引数を取得できる
  return $_[0] + $_[1] + $_[2]; #3つのスカラを合計して返す
}
print sum_3scalar 1,2,3; #プロトタイプに沿って呼び出し。結果：6
#print sum_3scalar 1,2;   #プロトタイプに沿わない呼び出し。コンパイルエラー
#結果：Not enough arguments for main::sum_3scalar at
#      C:\src\chap1\subArgument.pl line 7, near "2;"
print "</PRE></BODY></HTML>";
