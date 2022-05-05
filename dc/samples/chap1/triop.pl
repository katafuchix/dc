#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = 1;
$b = 2;
$c = 3;
print ($a ? $b : $c); #$aが真なので$bを返す。結果：2
print "\n";
if($a){               #if～else文で同様の処理を行う
  print $b;           #$aが真なので$bを出力。結果：2
}else{
  print $c;
}
print "\n";
($a ? $b : $c) = 4;   #左辺値として使用。$aが真なので$bに4を代入。
print $b;             #結果：4
print "</PRE></BODY></HTML>";
