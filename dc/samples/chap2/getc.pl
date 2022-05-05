#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"sample.txt";    #ファイルを開く
while(my $ch = getc INFILE){ #1バイトずつ読み込み
  print $ch;                 #結果：（ファイルの内容が出力される）
}                            #終端まで来るとwhileループが終了する
print "</PRE></BODY></HTML>";
