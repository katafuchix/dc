#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my @strings = ("Volleyball","Soccer","American Football","Baseball");
my $val = grep /ball/,@strings; #"ball"を含む要素数
print $val;                     #結果：3
print "\n";
print grep /ball/,@strings;     #結果：Volleyball American Football Baseball
print "\n";
grep {s/ball/BALL/g} @strings;  #ブロック内で正規表現でballをBALLに置換
print @strings;           #結果：VolleyBALL Soccer American FootBALL BaseBALL
print "</PRE></BODY></HTML>";
