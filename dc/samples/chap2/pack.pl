#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $str = "perl";
my @list = unpack("C*",$str); #��������char�l�Ƃ��ă��X�g�ɓW�J
foreach $i (@list){
  print $i;                   #���ʁF112,101,114,108
}
print "\n";
my @list2 = (67,71,73);
my $str2 = pack("C*",@list2); #��������char�l�Ƃ��ăo�C�i��������Ƀp�b�N
print $str2;                  #���ʁFCGI
print "</PRE></BODY></HTML>";
