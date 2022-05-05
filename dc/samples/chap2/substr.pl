#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $str1 = "ABCDEFG";
print substr($str1,2);   #2文字目以降切り出し。結果：CDEFG
print "\n";
print substr($str1,2,3); #2文字目から3文字切り出し。結果：CDE
print "\n";
print substr($str1,-2);  #末尾から2文字目以降切り出し 結果：FG
print "\n";
print substr($str1,2,-2);#2文字目～末尾から2文字目まで切り出し 結果：CDE
print "\n";
print substr($str1,4,-4);#4文字目～末尾から4文字目まで切り出し。
                         #範囲が交差するので切り出せない 結果：空文字列
print "\n";
my $str2 = substr($str1,2,2,"xyz"); #2文字目から2文字分を置換。
print $str1;             #置換結果文字列。結果：ABxyzEFG
print "\n";
print $str2;             #置換対象文字列が返る。結果：CD
print "\n";
$str1 = "ABCDEFG";       #$str1を元に戻す
substr($str1,2) = ".";   #2文字目以降を置換
print $str1;             #結果：AB.
print "\n";
$str1 = "ABCDEFG";       #$str1を元に戻す
substr($str1,2,3) = "-"; #2文字目から3文字置換
print $str1;             #結果：AB-FG
print "</PRE></BODY></HTML>";
