#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print abs(-2.5);                  #���ʁF2.5
print "\n";
print abs(2.0);                   #���ʁF2
print "\n";
print abs4(-2);                   #���ʁF2
print "\n";
@array = (2,3,-1,-4);
foreach(@array){                  #�z������ɏ���
  print abs;                      #$_�̐�Βl���o�́B���ʁF2 3 1 4
}
sub abs4 {                        #Perl 4�pabs
  ($_[0] > 0) ? $_[0] : -$_[0];
}
print "</PRE></BODY></HTML>";
