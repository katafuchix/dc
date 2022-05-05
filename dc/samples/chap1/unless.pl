#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 20;
unless ($val > 10){                    #条件式は真
  print "value is greater than 10";    #処理されない
}elsif($val > 0){                      #条件式は真
  print "value is greater than 0";     #結果：value is greater than 0
}
print "\n";
unless ($val <= 100){                    #条件式は真
  print "value is greater than 100";     #処理されない
}else{                                   #else文が処理される
  print "value is not greater than 100"; #結果：value is not greater than 100
}
print "\n";
print $val unless ($val < 0); #後ろのunless条件式を満たす時処理。結果：20
print "</PRE></BODY></HTML>";
