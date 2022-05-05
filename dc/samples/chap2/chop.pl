#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$str1 = "abc\n";
$str2 = "def";
@array = ("abc\n","def\n","ghi");
chop $str1;
chop $str2;
print $str1.$str2; #str1,str2の末尾文字を取り除く。結果：abcde
print "\n";
print @array;      #結果：abc（改行）def（改行）ghi
chop @array;       #配列のすべての末尾文字を取り除く
print "\n";
print @array;      #結果：abcdefgh
print "</PRE></BODY></HTML>";
