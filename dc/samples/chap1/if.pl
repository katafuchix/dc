#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 10;
if ($val > 5){                     #条件式は真
  print "value is greater than 5"; #結果：value is greater than 5
}
print "\n";
if ($val > 10){                    #条件式は偽
  print "value is greater than 10";#処理されない
}elsif($val > 0){                  #条件式は真
  print "value is greater than 0"; #結果：value is greater than 0
}
print "\n";
if ($val > 100){                         #条件式は偽
  print "value is greater than 100";     #処理されない
}else{                                   #else文が処理される
  print "value is not greater than 100"; #結果：value is not greater than 100
}
print "\n";
print $val if ($val >5); #後ろのif条件式を満たす時前の文を処理する。結果：10
print "</PRE></BODY></HTML>";
