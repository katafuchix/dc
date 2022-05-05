#!/usr/bin/perl
print "Content-type: text/html ; charset=shift-jis\n\n";
print "<HTML><BODY><PRE>";
$string = <<'EOC'; #次のEOCまで1つの文字列定数とみなし、シングルクォートで囲む
abcdefg
#コメントのように見えるが文字列定数の一部
print $value;
上のprint文もただの文字列定数
EOC
#'abcd～ただの文字列定数'までがシングルクォートで囲まれた文字列定数とみなされる
print $string;  #結果：abcdefg（改行）#コメントのように...（改行）...
print "</PRE></BODY></HTML>";
