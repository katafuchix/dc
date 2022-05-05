#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@array = (1,2,3,4,5,6);
@subarray = splice @array,2,2;    #3番目から2個取り除く
&printarray(@subarray);           #結果：34
@array = (1,2,3,4,5,6);
@subarray = splice @array,-5,-2;  #末尾から5番目から末尾から3番目まで取り除く
&printarray(@subarray);           #結果：234
@array = (1,2,3,4,5,6);
my @newarray = (a,b,c);
splice @array,2,2,@newarray;      #3番目から2個を別の配列で置換。長さも変化する
&printarray(@array);              #結果：12abc56
sub printarray{                   #配列の内容を出力するサブルーチン
  foreach $i (@_){
    print $i;
  }
  print "\n";
}
print "</PRE></BODY></HTML>";
