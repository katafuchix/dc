#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print ("a","b",10);  #3つの要素を並べたリストを出力。結果：ab10n
print "\n";
@list = (1,2,3,4,5); 
print @list;         #配列の要素を並べたリストを出力。結果：12345
print "\n";
%hash = ("key1"=>"value1","key2"=>"value2");
print %hash;#連想配列のキーと要素を交互に並べたリストを出力
#結果：key2value2key1value1
print "\n";
print (@list,%hash,"c"); #配列listの要素、連想配列hashのキーと値を
                         #交互に並べたリスト、"c"を順に連結したリストを返す
#結果：12345key2value2key1value1c
print "\n";
while(($key,$value) = each %hash){ #連想配列のキーと値を$keyと$valueに順に代入
  print "$key:$value";   #キーと値を出力。結果：key2:value2 key1:value1
}
print "</PRE></BODY></HTML>";
