#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print do {my $val = 2 * 4;my $val2 = $val + 2}; #最後の式の結果が返る。結果：10
print "\n";
print do sampleSub();                 #サブルーチンの返値が返る。結果：12
print "\n";
do "other.pl";                        #他のファイルの内容を実行する
 #結果：Other script
sub sampleSub{                        #サブルーチン例。12を返す
  return 3 * 4;
}
print "</PRE></BODY></HTML>";
