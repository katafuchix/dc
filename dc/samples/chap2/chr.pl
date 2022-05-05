#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print chr 64;     #@の文字コードは64。結果：@
print "\n";
print ord '@foo'; #先頭文字は@。結果：64
print "\n";
print ord "\t";   #先頭文字はタブ文字。結果：9
print "\n";
print ord "\n";   #先頭文字は改行文字。結果：10
print "\n";
print "abc",chr(10),"def"; #改行文字出力。結果：abc（改行）def
print "\n";
print "abc\ndef"; #上と同じ改行文字出力。結果：abc（改行）def
print "\n";
print "abc",chr(9),"def"; #タブ文字出力。結果：abc（タブ）def
print "\n";
print "abc\tdef"; #上と同じタブ文字出力。結果：abc（タブ）def
print "\n";
$string = "abcde";
for($i = 0 ; $i < length($string) ; $i++){
  print substr($string,$i,1);
  print ":";
  print ord(substr($string,$i,1));
} #1文字ずつ文字コードを出力。結果：a:97 b:98 c:99 d:100 e:101
print "</PRE></BODY></HTML>";
