#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@list = (1,2,3,4,5);#配列定義
foreach (@list){    #省略記法。@listの要素を1つずつ$_に代入
  print;            #省略記法。$_の内容を出力。結果：12345
}
print "\n";
foreach $i (@list){ #省略しない記法。@listの要素を1つずつ$iに代入
  print $i;         #省略しない記法。$iの内容を出力。結果：12345
}
print "\n";
for (1..5){         #省略記法。$_を1から5まで変えながらループ
  print;            #省略記法。$_の内容を出力。結果：12345
}
print "\n";
for ($i = 1 ; $i <=5 ; $i++){ #省略しない記法。$iを1から5まで変えながらループ
  print $i;         #省略しない記法。$iの内容を出力。結果：12345
}
print "</PRE></BODY></HTML>";
