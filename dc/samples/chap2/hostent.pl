#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sethostent 0;              #ホスト情報取得開始
while(@info = gethostent){ #ホスト情報取得
  print $info[0];          #ホスト名出力。結果：fedora4
}
endhostent;                #ホスト情報取得終了
print "</PRE></BODY></HTML>";
