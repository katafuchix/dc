#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print time; #1970 年 1 月 1 日 00:00:00からの秒数。結果例：1136488544
print "\n";
$time = time;
print scalar localtime($time); #結果：Thu Feb 23 15:26:57 2006
print "\n";
$time += 60 * 60 * 24; #1日分の秒数を加算
print scalar localtime($time + 1); #Fri Feb 24 15:26:57 2006
print "</PRE></BODY></HTML>";
