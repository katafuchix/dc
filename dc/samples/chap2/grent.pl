#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
setgrent;                #グループ情報取得開始
while(@info = getgrent){ #グループ情報取得
  print $info[0];        #グループ名出力。結果：root
  print "\n";
  print $info[3];        #メンバを出力。結果：root bin daemon
}
endgrent;                #グループ情報取得終了
print "</PRE></BODY></HTML>";
