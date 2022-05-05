#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $foo = 'perl';
printf "%c",vec($foo,  0, 8);  #1文字目をバイト単位で切り出し。結果：p
print "\n";
printf "%d",vec($foo,  0, 16); #2,3バイトを数値として切り出し。
print "\n";
#結果：28773 = 112（'p'） * 256 + 101（'e'）。先頭バイトから末尾バイトへ
vec($val,0,8) = 0x5;       #2進値：00000101
print vec($val,2,1);       #下位ビットから2ビットスキップして切り出し。結果：1
print "</PRE></BODY></HTML>";
