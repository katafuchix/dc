#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 10;
if ($val > 5){                     #�������͐^
  print "value is greater than 5"; #���ʁFvalue is greater than 5
}
print "\n";
if ($val > 10){                    #�������͋U
  print "value is greater than 10";#��������Ȃ�
}elsif($val > 0){                  #�������͐^
  print "value is greater than 0"; #���ʁFvalue is greater than 0
}
print "\n";
if ($val > 100){                         #�������͋U
  print "value is greater than 100";     #��������Ȃ�
}else{                                   #else�������������
  print "value is not greater than 100"; #���ʁFvalue is not greater than 100
}
print "\n";
print $val if ($val >5); #����if�������𖞂������O�̕�����������B���ʁF10
print "</PRE></BODY></HTML>";
