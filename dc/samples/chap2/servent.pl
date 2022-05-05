#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
setservent 1;              #サービス情報取得開始
while(@info = getservent){ #サービス情報取得
  print $info[0];          #サービス名出力。結果：tcpmux rje echo...
}
endservent;                #サービス情報取得終了
print "</PRE></BODY></HTML>";
