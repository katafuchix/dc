#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"seeksample.txt"; #読み込み専用でファイルを開く
sysread INFILE,$str,10;   #先頭10バイト読み込み
print $str;               #結果：abcdefghij
print "\n";
sysseek INFILE,5,0;       #5バイト目に移動
sysread INFILE,$str,5;    #5バイト読み込み
print $str;               #結果：fghij
close INFILE;
print "</PRE></BODY></HTML>";
