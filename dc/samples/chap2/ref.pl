#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
if (ref($var) eq "HASH") { #型を判定する
  print "$varは連想配列";  #連想配列の場合
}
print ref(\&subA);         #サブルーチンのリファレンス。結果：CODE
print "\n";
print ref($a);             #リファレンスではない。結果：（なし）
sub subA{
}
print "</PRE></BODY></HTML>";
