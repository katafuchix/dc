#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 0;
until($val > 5){                #条件を最初に評価し、偽の間ループ
  print $val;                   #結果：012345
  $val++;                       #インクリメント
}
print $val++ until ($val > 3); #最初から条件式が真なので文は処理されない
print "</PRE></BODY></HTML>";
