#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$_ = "abracadabra";  #検索対象文字列を$_に代入
if(/ab/){            #abでパターンマッチ
  print '"ab" match';#結果："ab" match
}
print "\n";
while(m@a@g){        #m演算子を使い、@を区切り文字とし、g修飾子で繰り返す
  print pos;         #aのマッチ位置を出力。1 4 6 8 11
}
print "\n";
while(m[AB]ig){      #[]を区切り文字とし、i修飾子で大文字小文字無視
  print pos;         #ABのマッチ位置を出力。2 9
}
print "\n";
$string = "abcdefg";  #検索対象文字列
if($string =~ /cde/g){#=~演算子でパターンマッチ対象を$stringとする
  print pos $string;  #cdeのマッチ位置を出力。5
}
print "\n";
if($string !~ /zzz/){ #!~演算子でパターンマッチ対象を$stringとする
  print "zzz not found"; #結果：zzz not found
}
print "</PRE></BODY></HTML>";
