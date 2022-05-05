#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
dbmopen %db,"test",0666; #testを書き込み用に開く
$db{"test"} = 10;        #連想配列に書き込み→DBMに書き込み
dbmclose %db;            #結合解除
dbmopen %db2,"test",0644;#再度読み込み用に開く
print $db2{"test"};      #内容出力。結果：10
dbmclose %db2;
print "</PRE></BODY></HTML>";
