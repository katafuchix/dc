#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@strings = ("Volleyball","Soccer","American Football","Baseball");
@vals = map {length} @strings;#それぞれのバイト数をカウント
print join ",",@vals;         #結果：10,6,17,8
print "\n";
print join ",",@strings;      #元配列表示。書き換わっていない
 #結果：Volleyball,Soccer,AmericanFootball,Baseball
print "\n";
@strings2 = map uc,@strings;  #それぞれ大文字に変換
print join ",",@strings2;     #結果配列表示
 #結果：VOLLEYBALL,SOCCER,AMERICAN FOOTBALL,BASEBALL
print "\n";
print join ",",@strings;      #元配列表示。書き換わっていない
 #結果：Volleyball,Soccer,AmericanFootball,Baseball
print "\n";
map {$_ = reverse;} @strings; #文字列を逆順に。ブロックで$_を書き換え
print join ",",@strings;      #元の配列が書き換わる
 #結果：llabyelloV,reccoS,llabtooFnaciremA,llabesaB
print "</PRE></BODY></HTML>";
