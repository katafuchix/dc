#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@list = (1..5);      #配列変数を定義して1,2,3,4,5でなるリストを代入
print scalar @list;  #配列のサイズを出力。結果：5
print "\n";
print $list[0];      #配列の0番目を出力。結果：1
print "\n";
$list[0] = 6;        #配列の0番目に代入
foreach $i (@list){  #配列の値を順に$iに代入
  print $i;          #配列の値を順に出力。結果：62345
}
print "\n";
@list2 = @list[2,3,4];#配列の2、3、4番目をリストとして取得して別の配列に代入
foreach $i (@list2){ #配列の値を順に$iに代入
  print $i;          #配列の値を順に出力。結果：345
}
print "\n";
@list3 = @list[0..2];#配列の0～2番目をリストとして取得して別の配列に代入
foreach $i (@list3){ #配列の値を順に$iに代入
  print $i;          #配列の値を順に出力。結果：623
} 
print "\n";
@list[2,3] = (0,-1); #配列の2,3番目を別のリストに変更
foreach $i (@list){  #配列の値を順に$iに代入
  print $i;          #配列の値を順に出力。結果：6 2 0 -1 5
}
print "\n";
print $#list;        #配列のインデックス上限を出力。結果：4
print "\n";
$#list = 2;          #配列のインデックス上限を2に変更
foreach $i (@list){  #配列の値を順に$iに代入
  print $i;          #配列の値を順に出力。結果：620
} #インデックス3より上にあった-1,5は破棄されている
print "</PRE></BODY></HTML>";
