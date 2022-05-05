#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@values = (0,1,2,3,4,5,6,7,8,9);    #配列定義
foreach $value (@values){           #配列の要素を順に取り出して$valueに代入
  print $value;                     #要素を出力。結果：0123456789
}
print "\n";
foreach $value (@values){           #上と同様
  print $value;
}continue{                          #ループ処理後に毎回処理
  print "next";                     #結果：nextnextnext....
} #実際には6行目と8行目が交互に処理される。結果：0next1next2next3next...
print "\n";
%days = ("Sunday" => "日",          #連想配列定義
         "Monday" => "月",
         "Tuesday"=>"火");
foreach $str (values %days){        #連想配列の値を順に取り出して$strに代入
  print $str;                       #値を出力。結果：火日月
}
print "</PRE></BODY></HTML>";
