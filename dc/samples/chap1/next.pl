#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 0;         #ループ用の変数
while($val < 10){ #10回ループするwhile文
  $val++;         #インクリメント
  if($val < 5){   #5未満の場合は
    next;         #次のループへ
  }
  print $val;     #値出力。結果：5678910
}
print "\n";
@values = (0..4); #配列定義
foreach $value (@values){        #順に値を取り出す
  if($value < 2){                #2未満なら
    next;                        #次のループへ。ただしcontinueブロックを処理する
  }
  print $value;                  #値出力
}continue{                       #ループ処理後に毎回処理
  print "next";
}#結果：nextnext2next3next4next
print "</PRE></BODY></HTML>";
