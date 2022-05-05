#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = "global";        #グローバル変数定義
{
  local $a = "local"; #ローカル変数定義
  print $a;           #結果：local
}
print "\n";
print $a;             #グローバル変数は書き換わらない。結果：global
print "\n";
{
  my $a = "my";       #ローカル変数定義
  print $a;           #結果：my
} 
print "</PRE></BODY></HTML>";
