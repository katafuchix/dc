#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $ret = fork;       #forkで2プロセスに分岐
if($ret != 0){        #プロセスIDが0かどうかで親子を見分ける
  print $ret;         #子プロセスID表示。結果：-4052
  print wait;         #子プロセス終了待ち。結果：-4052
}else{
  exit;               #子プロセスを終了させる
}
my $ret2 = fork;      #forkで2プロセスに分岐
if($ret2 != 0){
  print waitpid $ret2,WNOHANG; #子プロセスを指定して終了待ちする。結果：-832
}
print "</PRE></BODY></HTML>";
