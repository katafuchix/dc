#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $val = 4,my $val2 = 0;
print eval {$val = 2};   #最後の文の結果が返る。結果：2
eval {$val / $val2};     #0除算エラー発生
print "\n";
if($@){                  #エラーメッセージチェック
  print $@; #結果：2Illegal division by zero at C:\src\chap2\eval.pl line 3.
}
print "</PRE></BODY></HTML>";
