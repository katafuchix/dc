#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@list = stat "sample.txt";       #sample.txtの情報取得
for(0..12){                      #0-12まで戻り値の内容を出力
  print "$_:";
  unless($_ >= 8 && $_<=10){     #8-10以外はそのまま出力
    print $list[$_];
  }else{                         #8-10の場合は
    print scalar localtime($list[$_]); #localtime関数で変換
  }
  print "\n";
}
print "</PRE></BODY></HTML>";
