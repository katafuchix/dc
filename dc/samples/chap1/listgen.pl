#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@list = (0..10);      #0から10までの値を持つ配列を生成
foreach $i (@list){   #値を順に取り出す
  print $i;           #結果：012345678910
}
print "\n";
@list = (2.4..6.3);   #浮動小数点数は整数値に変換。2から6までの配列を生成
foreach $i (@list){   #値を順に取り出す
  print $i;           #結果：23456
}
print "\n";
@list = ("a0".."b3"); #a0からb3までの値を持つ配列を生成
#マジカルインクリメントと同様に文字列をインクリメントしていく
foreach $i (@list){   #値を準に取り出す
  print $i;           #結果：a0a1a2a3a4a5a6a7a8a9b0b1b2b3
}
print "</PRE></BODY></HTML>";
