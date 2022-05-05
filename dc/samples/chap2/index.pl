#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$string = "hogehoge";
$substr1 = "ge"; #検索する文字列。#2,6文字目に見つかるはず
print index $string,$substr1;     #先頭から検索。結果例：2
print "\n";
print rindex $string,$substr1;    #末尾から検索。結果例：6
print "\n";
print index $string,$substr1,3;   #先頭から3文字目から検索。結果例：6
print "\n";
print rindex $string,$substr1,3;  #末尾から3文字目から検索。結果例：2
print "\n";
$substr2 = "oh";                  #検索する文字列。見つからないはず
print index $string,$substr2;     #検索失敗。結果例：-1
print "</PRE></BODY></HTML>";
