#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
for($i = 0 ; $i < 5 ; $i++){
  push @array,$i;           #配列に要素を1つずつ追加
}#配列内は0,1,2,3,4の順
@array2 = (a,b,c);
push @array,@array2;        #配列に配列を追加
$num = $#array + 1;         #配列の要素数取得。最大インデックス＋1
for($j = 0 ; $j < $num + 1 ; $j++){ #わざと1回多くループさせる
  $val = pop @array;
  print $val;               #結果：4321abc0
  if($val eq undef){        #最後のループでは
    print "underflow";      #配列が空なのでundefが返る。結果：undeflow
  }
}
print "</PRE></BODY></HTML>";
