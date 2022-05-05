#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$str = "abcdefghijk 12345 abcdefg";
while($str =~ m/cde/g){ #"cde"でm//gサーチ
  print pos $str;       #マッチ位置を出力。結果：5,23
}
print "\n";
pos $str = 10;          #次回のパターンマッチングを10文字目からに設定
while($str =~ m/cde/g){ #"cde"でm//gサーチ
  print pos $str;       #マッチ位置を出力。5文字目はマッチしない。結果：23
}
print "</PRE></BODY></HTML>";
