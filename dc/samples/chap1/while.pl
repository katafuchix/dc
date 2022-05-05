#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 0;
while($val <= 5){               #条件を最初に評価し、真の間ループ
  print $val;                   #結果：012345
  $val++;                       #インクリメント
} continue {                    #ブロック処理後に毎回処理される
  print $val;                   #結果：123456
} #実際には3行目のprint文と6行目のprint文が交互に呼ばれるので結果は011223344556
print "\n";
$val = 0;
print $val++ while ($val <= 5); #上と同様。結果：012345
print "\n";
$val = 10;
print $val++ while ($val <= 5); #最初から条件式が偽なので文は処理されない
print "\n";
do {                            #条件式の評価より先にブロックを1回処理する
  print $val;                   #結果：10
  $val++;
}while ($val <= 5);             #条件式は偽なのでループはしない
#while(1){                       #無限ループ
#  print "a";                    #結果：aaaaaaaaa...
#}
print "</PRE></BODY></HTML>";
