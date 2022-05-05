#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 0;
while(1){                #無限ループ
  print $val++;          #インクリメントしつつ値を出力。結果：01234
  if($val == 5){         #値が5になったら
    last;                #ループ処理終了
  }
}
print "\n";
while(<STDIN>){          #入力を読み込む
  if(/^quit$/){          #quitと入力すると
    last;                #処理を終了する
  }
  print $_;              #それ以外は入力された文字を出力する
}
print "</PRE></BODY></HTML>";
