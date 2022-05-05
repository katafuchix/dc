#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $val = &sub1;  #結果：スカラ or voidコンテキスト
print "\n";
&sub1;            #voidコンテキストで呼び出し。結果：スカラ or voidコンテキスト
print "\n";
my @vals = &sub1; #結果：リストコンテキスト
print "\n";
foreach (@vals){  #リストコンテキストで帰ってきたリストを出力
  print;          #結果：list context value
}
sub sub1{
  if(wantarray){  #戻り値が真ならリスト、偽ならスカラ（もしくは無効）
    print "リストコンテキスト";
    return ("list","context","value");  #リストコンテキストではリストを返す
  }else{
    print "スカラ or voidコンテキスト";
    return "scalar or void";    #文字列を返す
  }
}
print "</PRE></BODY></HTML>";
