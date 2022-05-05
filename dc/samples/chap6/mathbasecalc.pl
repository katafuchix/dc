#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BaseCalc;
$base5 = new Math::BaseCalc(digits => [0..4]);         #0～4を用いた5進数
$base7 = new Math::BaseCalc(digits => [0..4,'a','B']);
#0～4とaとBを用いた変則7進数
print $base5->to_base(20);  #20を5進数化。結果：40
print "\n";
print $base7->to_base(20);  #20を変則7進数化。結果：2B（7 * 2 + 6）
print "\n";
print $base7->to_base( $base5->from_base("400")); #5進数から7進数へ変換
#5進数の400→10進数100→7進数202(7**2 * 2 + 7**1 * 0 + 2)。結果：202
print "\n";
print $base7->digits(); #用いている数値リストを出力。結果：01234aB
print "\n";
$base7->digits(['a','b','c']); #7進数をabcを用いる3進数に変更
print $base7->to_base(20);  #20を3進数化。結果：cac
print "\n";
$hex = new Math::BaseCalc(digits => "hex"); #小文字16進数
print $hex->digits(); #用いている数値リストを出力。結果：0123456789abcdef
print "\n";
$bin = new Math::BaseCalc(digits => "bin"); #2進数
print $bin->digits(); #用いている数値リストを出力。結果：01
print "\n";
print $hex->to_base($bin->from_base("1011110")); #2進数から16進数へ変換
#結果：5e
print "</PRE></BODY></HTML>";
