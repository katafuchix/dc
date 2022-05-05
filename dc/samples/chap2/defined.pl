#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sub a{
}
print not defined $b; #変数$bは未定義。結果：1
print "\n";
print defined &a;     #サブルーチン&aは定義されている。結果：1
print "</PRE></BODY></HTML>";
