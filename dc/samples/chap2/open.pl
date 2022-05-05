#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"<sample.txt";     #sample.txtを読み込み専用で開く
close INFILE;                  #ファイルを閉じる
open OUTFILE,">sample.txt";    #sample.txtを書き込み専用で開く（上書き）
print OUTFILE "create";        #ファイルに書き込む
close OUTFILE;
open INOUTFILE,"+<sample.txt"; #sample.txtを読み書き両用で開く
print getc INOUTFILE;          #ファイル内容を1文字読み込む。結果：c
print "\n";
print INOUTFILE "read/write";  #ファイルに書き込む
close INOUTFILE;
open OUTFILE,">>sample.txt";   #sample.txtを追記用で開く
print OUTFILE "append";        #ファイルに追記する
close OUTFILE;
open INFILE,"dir /w/b *.pl|";  #dirコマンドの結果をパイプ入力。Linuxではlsを使用
@dir = <INFILE>;               #結果を読み取る
close INFILE;
foreach(@dir){
  print;                      #結果：abs.pl accept.pl alarm.pl ...
}
open OUTFILE,"| sort";         #文字列をソートするsortコマンドにパイプ出力
@list = ("xyz","abc","def");   #ソート前配列
foreach(@list){
  print OUTFILE;               #OUTFILEに文字列出力
  print OUTFILE "\n";
}
close OUTFILE;                 #OUTFILEを閉じる
#結果（sortコマンドが出力する）：
#abc
#def
#xyz
print "</PRE></BODY></HTML>";
