#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 20;
unless ($val > 10){                    #�������͐^
  print "value is greater than 10";    #��������Ȃ�
}elsif($val > 0){                      #�������͐^
  print "value is greater than 0";     #���ʁFvalue is greater than 0
}
print "\n";
unless ($val <= 100){                    #�������͐^
  print "value is greater than 100";     #��������Ȃ�
}else{                                   #else�������������
  print "value is not greater than 100"; #���ʁFvalue is not greater than 100
}
print "\n";
print $val unless ($val < 0); #����unless�������𖞂����������B���ʁF20
print "</PRE></BODY></HTML>";
