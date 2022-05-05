#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$str1 = "abc\n";
$str2 = "def";
@array = ("abc\n","def\n","ghi");
print $str1.$str2; #結果：abc（改行）def
print "\n";
chomp $str1;
print $str1.$str2; #str1の末尾の\nを取り除く。結果：abcdef
print "\n";
print @array;      #結果：abc（改行）def（改行）ghi
print "\n";
chomp @array;      #配列のすべての末尾の改行文字を取り除く
print @array;      #結果：abcdefghi
print "</PRE></BODY></HTML>";
