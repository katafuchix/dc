#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@array = (1,2,3,4,5,6);
@rarray = reverse @array;
&printarray(@rarray);      #���ёւ��B���ʁF654321
&printarray(@array);       #���z��͕ω������B���ʁF123456

my $str = "abcdef";
$rstr = reverse $str;
print $rstr;               #���ёւ��B���ʁFfedcba
print "\n";
print $str;                #��������͕ω������B���ʁFabcdef

sub printarray{            #�z��̓��e���o�͂���T�u���[�`��
  foreach $i (@_){
    print $i;
  }
  print "\n";
}
print "</PRE></BODY></HTML>";
