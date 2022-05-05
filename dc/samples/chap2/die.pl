#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
#chdir "zzzz" || die "終了：$!"; #存在しないフォルダへ移動。失敗したら終了
 #結果：終了：No such file or directory at C:\src\chap2\die.pl line 1.

eval{ chdir "zzzz" || die "CD failed..."}; #eval内で存在しないフォルダへ移動
 #die関数が呼び出されるが、eval関数が終了するだけ

if($@){                         #$@にエラーメッセージが入っているか
  print "eval内でdie:".$@;      #エラーメッセージ表示
} #結果：eval内でdie:CD failed... at C:\src\chap2\die.pl line 3.
print "</PRE></BODY></HTML>";
