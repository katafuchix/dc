#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print scalar localtime;  #現在時刻。結果：Fri Jan  6 04:08:35 2006
print "\n";
print join ",",localtime;#リスト内容。結果：35,8,4,6,0,106,5,5,0
print "</PRE></BODY></HTML>";
