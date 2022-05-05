#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open OUTFILE,">sample2.txt";            #書き込み専用でファイルを開く
print syswrite OUTFILE,"test",3;        #先頭3バイトだけ書き込み。結果：3
print "\n";
print syswrite OUTFILE,"abcdefg",10,-3; #末尾3バイトだけ書き込み。結果：3
close OUTFILE;                          #ファイル内容：tesefg
print "</PRE></BODY></HTML>";
