#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my @strings = ("Volleyball","Soccer","American Football","Baseball");
my $val = grep /ball/,@strings; #"ball"���܂ޗv�f��
print $val;                     #���ʁF3
print "\n";
print grep /ball/,@strings;     #���ʁFVolleyball American Football Baseball
print "\n";
grep {s/ball/BALL/g} @strings;  #�u���b�N���Ő��K�\����ball��BALL�ɒu��
print @strings;           #���ʁFVolleyBALL Soccer American FootBALL BaseBALL
print "</PRE></BODY></HTML>";
