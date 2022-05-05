#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
%days = ("Sunday" => "日","Monday" => "月","Tuesday"=>"火");
print values %days;        #リストコンテキストとして評価。結果：火日月
print "\n";
print scalar values %days; #スカラコンテキストとして評価。結果：3
print "</PRE></BODY></HTML>";
