#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"sample.txt"; #ファイルを開く
if(not eof INFILE){
  print "non-EOF";        #結果：non-EOF
}
print "\n";
while(<INFILE>){          #ファイル全体を読み込み
}
if(eof INFILE){
  print "EOF";            #結果：EOF
}
print "</PRE></BODY></HTML>";
