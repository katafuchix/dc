#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $ret = fork;       #forkで2プロセスに分岐
if($ret != 0){        #プロセスIDが0かどうかで親子を見分ける
  print "親プロセス";
}else{
  print "子プロセス";
} #結果：子プロセス 親プロセス
print "</PRE></BODY></HTML>";
