#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$_ = "abcdefghijk 12345 abcdefg"x1000000; #非常に長い文字列
$time = time;     #時間記録
for(0..10000000){ #10000000回ループ
  while(m/cde/g){ #"cde"でm//gサーチ
  }
}
$time2 = time;    #時間記録
print $time2 - $time; #study関数無しの結果。結果例：25
print "\n";
study;            #$_に対しての学習を行う
for(0..10000000){ #10000000回ループ
  while(m/cde/g){ #"cde"でm//gサーチ
  }
}
$time3 = time;    #時間記録
print $time3 - $time2; #study関数有りの結果。結果例：21
print "</PRE></BODY></HTML>";
