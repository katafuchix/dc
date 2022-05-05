#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
($usertime,$systemtime,$childusertime,$childsystemtime) = times; #時間取得
print $usertime;   #ユーザ時間。結果：0.031
print "\n";
print $systemtime; #システム時間。結果：0.015
print "\n";
print $cusertime;  #子プロセスユーザ時間。結果：（なし）
print "\n";
print $csystemtime;#子プロセスシステム時間。結果：（なし）
print "</PRE></BODY></HTML>";
