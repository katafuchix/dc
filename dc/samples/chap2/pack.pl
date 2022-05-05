#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $str = "perl";
my @list = unpack("C*",$str); #符号無しchar値としてリストに展開
foreach $i (@list){
  print $i;                   #結果：112,101,114,108
}
print "\n";
my @list2 = (67,71,73);
my $str2 = pack("C*",@list2); #符号無しchar値としてバイナリ文字列にパック
print $str2;                  #結果：CGI
print "</PRE></BODY></HTML>";
