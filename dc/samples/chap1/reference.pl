#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 10;            #スカラ変数
$refval = \$val;      #リファレンスをスカラ変数に代入
print $$refval;       #識別子$を付けて参照。結果：10
print "\n";
@list = (1,2,3,4,5);  #配列変数
$reflist = \@list;    #リファレンスをスカラ変数に代入
print $reflist->[2];  #アロー演算子で参照。結果：3
print "\n";
%hash = ("Sunday" => "日","Monday" => "月","Tuesday"=>"火"); #連想配列変数
$refhash = \%hash;           #リファレンスをスカラ変数に代入
foreach $i (keys %$refhash){ #識別子%を付けて参照。
  print $i;                  #結果：TuesdayMondaySunday
}
print "\n";
$reflist2 = [5..9];          #リストのリファレンスをスカラ変数に代入
print @$reflist2;            #識別子@を付けて参照。結果：56789
print "</PRE></BODY></HTML>";
