#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"sample.txt";
read INFILE,$str,5;       #5バイト読み込む
my $pos = tell INFILE;    #現在の読み書き位置を保存
print $pos;               #結果：5
print "\n";
read INFILE,$str,5;       #5バイト読み込む
print tell INFILE;        #結果：10
print "\n";
seek INFILE,$pos,0;       #保存しておいた位置に移動
print tell INFILE;        #結果：5
print "\n";
seek INFILE,5,1;          #現在位置から5バイト移動
print tell INFILE;        #結果：10
print "\n";
seek INFILE,5,2;          #ファイル末尾から5バイトの位置に移動
print tell INFILE;        #結果：24
print "</PRE></BODY></HTML>";
