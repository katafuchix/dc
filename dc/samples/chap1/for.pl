#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
for($val = 0 ; $val < 5 ; $val++){ #よく用いられるパターン
  #$valを0に初期化し、5未満の間ブロックを処理し、ループごとにインクリメントする
  print $val; #結果：01234
}
print "\n";
for (1..5){         #省略記法。$_を1から5まで変えながらループ
  print;            #省略記法。$_の内容を出力。結果：12345
}
#for(;;){     #無限ループ
#  print "a"; #結果：aaaaaaa...
#}
print "</PRE></BODY></HTML>";
