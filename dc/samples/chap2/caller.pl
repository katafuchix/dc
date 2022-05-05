#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
&main;
sub main{
  &sub1;
}
sub sub1{
  print join ",",caller;   #直前の呼び出し元情報
  print "\n";
  #結果：main,C:\src\chap2\caller.pl,3
  &sub2;
}
sub sub2{
  &sub3;
}
sub sub3{
  print join ",",caller 2; #2つ前の呼び出し元情報。サブルーチン名はsub1
  #結果：main,C:\src\chap2\caller.pl,3,main::sub1,0,,,,0,
}
print "</PRE></BODY></HTML>";
