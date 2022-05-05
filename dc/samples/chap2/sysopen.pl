#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sysopen INFILE,"sample.txt",O_RDONLY; #読み取り専用でファイルを開く
print sysread INFILE,$str,10;         #読み込み。結果：10
close INFILE;
sysopen OUTFILE,"sample2.txt",O_WRONLY|O_CREATE; #書き込み専用でファイルを開く
print OUTFILE "test";
close OUTFILE;
print "</PRE></BODY></HTML>";
