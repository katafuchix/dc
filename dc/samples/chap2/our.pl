#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sub a{
  my $a;            #ローカル変数
  our $b;           #グローバル変数
  BEGIN{            #1度だけ値を初期化
    $a = 10;$b = 10;$c = 10; #$cもグローバル変数
  }
  $a++;$b++;$c++;   #インクリメント
  print '$a=',$a;   #ローカル変数は2回目には値を失う。結果：11 , 1 , 1
  print "\n";
  print '$b=',$b;   #グローバル変数は値を保ち続ける。結果：11,12,13
  print "\n";
  print '$c=',$c;   #グローバル変数は値を保ち続ける。結果：11,12,13
  print "\n";
}
&a;&a;&a;           #3回呼び出す
print "</PRE></BODY></HTML>";
