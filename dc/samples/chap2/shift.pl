#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
for($i = 0 ; $i < 5 ; $i++){
  unshift @array,$i;        #配列先頭に要素を1つずつ追加
}#配列内は4,3,2,1,0の順
@array2 = (a,b,c);
unshift @array,@array2;     #配列先頭に配列を追加
$num = $#array + 1;         #配列の要素数取得。最大インデックス＋1
for($j = 0 ; $j < $num + 1 ; $j++){ #わざと1回多くループさせる
  $val = shift @array;
  print $val;               #結果：abc43210
  if($val eq undef){        #最後のループでは
    print "underflow";      #配列が空なのでundefが返る。結果：undeflow
  }
}
print "</PRE></BODY></HTML>";
