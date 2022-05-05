#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = 5;$b = "A7";$c = "Az";
print $a++; #後に置いてあるので値を返してからインクリメント。結果：5
print "\n";
print ++$a; #先に置いてあるのでインクリメントしてから値を返す。結果：7
print "\n";
print --$a; #先に置いてあるのでデクリメントしてから値を返す。結果：6
print "\n";
print $a--; #後に置いてあるので値を返してからデクリメント。結果：6
print "\n";
print $a;   #変数はデクリメントされている。結果：5
print "\n";
print ++$b; #文字列をマジカルインクリメント。結果：A8
print "\n";
print ++$c; #マジカルインクリメントで桁上げ発生。結果：Ba
#print ++("Az"); #コンパイルエラー。マジカルインクリメントは変数に対してのみ
#Can't modify constant item in preincrement (++) at C:\src\chap1\incdec.pl
print "</PRE></BODY></HTML>";
