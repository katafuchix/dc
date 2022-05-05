#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
setprotoent 1;              #プロトコル情報取得開始
while(@info = getprotoent){ #プロトコル情報取得
  print $info[0];           #プロトコル名出力。結果：ip icmp tcp...
}
endprotoent;                #プロトコル情報取得終了
print "</PRE></BODY></HTML>";
