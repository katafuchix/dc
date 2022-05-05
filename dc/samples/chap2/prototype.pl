#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sub a($$@$$%&*){             #プロトタイプ宣言をした関数
}
print prototype \&a;        #結果：$$@$$%&*
print "\n";
print prototype "CORE::open";#open関数のプロトタイプ宣言取得。結果。*;$@
print "</PRE></BODY></HTML>";
