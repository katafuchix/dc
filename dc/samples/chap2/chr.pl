#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print chr 64;     #@�̕����R�[�h��64�B���ʁF@
print "\n";
print ord '@foo'; #�擪������@�B���ʁF64
print "\n";
print ord "\t";   #�擪�����̓^�u�����B���ʁF9
print "\n";
print ord "\n";   #�擪�����͉��s�����B���ʁF10
print "\n";
print "abc",chr(10),"def"; #���s�����o�́B���ʁFabc�i���s�jdef
print "\n";
print "abc\ndef"; #��Ɠ������s�����o�́B���ʁFabc�i���s�jdef
print "\n";
print "abc",chr(9),"def"; #�^�u�����o�́B���ʁFabc�i�^�u�jdef
print "\n";
print "abc\tdef"; #��Ɠ����^�u�����o�́B���ʁFabc�i�^�u�jdef
print "\n";
$string = "abcde";
for($i = 0 ; $i < length($string) ; $i++){
  print substr($string,$i,1);
  print ":";
  print ord(substr($string,$i,1));
} #1�����������R�[�h���o�́B���ʁFa:97 b:98 c:99 d:100 e:101
print "</PRE></BODY></HTML>";
