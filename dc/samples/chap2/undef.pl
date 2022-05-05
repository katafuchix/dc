#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sub a{
  print "test";
}
$val = 10;
print $val; #結果：10
print "\n";
undef $val; #変数を未定義にする
print $val; #結果：（なし）
print "\n";
@list = (1,2,3);
print @list;#結果：1 2 3
undef @list;#配列を未定義にする
print "\n";
print @list;#結果：（なし）
print "\n";
&a;         #この時点では呼べる。結果：test
undef &a;   #サブルーチンを未定義にする
#&a;#結果：Undefined subroutine &main::a called at C:\src\chap3\undef.pl line 8.
#ただしエラーメッセージが最初に出力される
print "</PRE></BODY></HTML>";
