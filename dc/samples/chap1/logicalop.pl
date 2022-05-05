#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = "Hello";
$b = "World";
$c = undef;
print $a && $b;    #論理積。結果：World（右側の項の値）
print "\n";
print $a and $c;   #andの優先順位が弱いので(print $a) and $bと評価される
                   #結果：Hello（左側の項の値）
print "\n";
print ($a and $c); #演算順序を明示して論理積。結果：（なし：右側の項の値）
print "\n";
print $a || &B;    #サブルーチンBは呼ばない。結果：Hello（左側の項の値）
print "\n";
print $c or &B;    #andの優先順位が弱いので(print $c) and &Bと評価される
                   #結果：Sub B（undefなので何も出力せず、その後B呼び出し）
print "\n";
print ($c or &B);  #演算順序を明示。Bは呼ばない。結果：Hello（左側の項の値）
$d = 1;
$e = 0;
print ($d xor $e);   #排他論理和。結果：1（左側の項の値）
print "\n";
print ($e xor $d);   #排他論理和。結果：1（右側の項の値）
print "\n";
print ($e xor $e);   #排他論理和。結果：（なし：undef）
print "\n";
print ($d xor $d);   #排他論理和。結果：（なし：undef）
sub B{
  print "Sub B";
  return "World";
}
$a = "hello";
$b = undef;
print !$a;    #結果：（なし）
print "\n";
print not $a; #結果：（なし）
print "\n";
print !$b;    #結果：1
print "\n";
print not $b; #結果：1
print "</PRE></BODY></HTML>";
