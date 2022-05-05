#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print rand 10; #自動的にsrandが呼び出される。結果例：6.048583984375
print "\n";
print rand 10; #この2行は実行するごとに値が変わる。
print "\n";
srand 1;       #シードを明示的に指定
print rand;    #何度実行しても常に同じ結果になる。結果例：0.001251220703125
print "\n";
print rand;    #結果例：0.563568115234375
srand (time ^ $$ ^ unpack "%L*", `ps axww | gzip`); 
               #よりランダムなシード（UNIX系OSの場合）
print "</PRE></BODY></HTML>";
