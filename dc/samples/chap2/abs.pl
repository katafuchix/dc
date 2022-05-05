#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print abs(-2.5);                  #結果：2.5
print "\n";
print abs(2.0);                   #結果：2
print "\n";
print abs4(-2);                   #結果：2
print "\n";
@array = (2,3,-1,-4);
foreach(@array){                  #配列を順に処理
  print abs;                      #$_の絶対値を出力。結果：2 3 1 4
}
sub abs4 {                        #Perl 4用abs
  ($_[0] > 0) ? $_[0] : -$_[0];
}
print "</PRE></BODY></HTML>";
