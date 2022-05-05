#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
setnetent;                #ネットワーク情報取得開始
while(@info = getnetent){ #ネットワーク情報取得
  print $info[0];         #ネットワーク名出力。結果：loopback
}
endnetent;                #ネットワーク情報取得終了
print "</PRE></BODY></HTML>";
