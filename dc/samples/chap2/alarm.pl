#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
eval {
  local $SIG{ALRM} = sub { die "alarm\n" }; #SIGALRM受信時はalarm\nを送出してdie
  alarm 3;                                  #3秒後にアラーム設定
  sleep 10;                                 #時間のかかる処理
  alarm 0;                                  #アラーム解除
};
if($@){     #eval中にエラーが発生した場合
  print $@; #メッセージ出力。alarmが原因であれば結果：alarm
}
print "</PRE></BODY></HTML>";
