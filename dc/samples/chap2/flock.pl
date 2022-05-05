#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open OUTFILE,">flock.txt";    #ファイルを書き込み用に開く
flock OUTFILE,2;              #排他ロックをかける
print OUTFILE "排他ロック中"; #書き込み
flock OUTFILE,8;              #ロック解除
close OUTFILE;
print "</PRE></BODY></HTML>";
