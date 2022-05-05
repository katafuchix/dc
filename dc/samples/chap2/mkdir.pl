#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
mkdir "test",0755;         #testディレクトリ作成
open OUT,">test/test.txt"; #testディレクトリ内にファイル作成
print OUT "test";
close OUT;
print rmdir "test";        #testディレクトリは空でないので削除失敗。結果：0
print "\n";
print $!;                  #エラーメッセージを出力。結果：Directory not empty
print "</PRE></BODY></HTML>";
