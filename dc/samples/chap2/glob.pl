#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
while(glob "*.pl"){ #すべてのスクリプトファイルを順に取り出す
  print;            #ファイルを順に出力。結果：abs.pl binmode.pl...
  print "\n";
}
print "</PRE></BODY></HTML>";
