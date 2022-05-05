#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print hex '0x64'; #一般的な16進表記。結果：100
print "\n";
print hex '014';  #先頭に0が付いていても16進数で評価。結果：20
print "\n";
print hex '64';   #先頭に何も付いていなくても16進で評価。結果：100
print "\n";
print oct '014';  #8進数で評価。結果：12
print "\n";
print oct '0x14'; #先頭に0xを付けると16進数で評価。結果：20
print "\n";
print oct '14';   #先頭に何も付けないと8進数で評価。結果：12
print "</PRE></BODY></HTML>";
