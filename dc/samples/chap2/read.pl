#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"readsample.txt";   #readsample.txtはサイズ17バイト
print read INFILE,$str,20;      #実際に読み込めたのは17バイト。結果：17
close INFILE;
open INFILE,"readsample.txt";   #ファイルを開く
@in = <INFILE>; #リストコンテキストで<>演算子使用。ファイルをすべて読み込む
while(<>){                      #標準入力から1行ずつ$_に読み込む
  print;                        #$_を出力する
}
print "</PRE></BODY></HTML>";
