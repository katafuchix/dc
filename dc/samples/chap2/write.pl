#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
format =
#報告書フォーマット指定
Name : @<<<<<<<<<<<<< @<<<<<<<<<<<
$firstName,$lastName
#変数行。2つの変数を指定
Summary : @<<<<<<<<<<<<<<<<<<<<<<<<<...
$summary
.

#フォーマット宣言。どの変数がどのフィールドに入るかを指定する
#ここではNameとSummaryの2つの出力行に3つの変数を指定している
$firstName = "Tsuyoshi"; #Name行に出力
$lastName = "Doi";       #Name行に出力
$summary = "始末書レポート。いろいろと内容がありました"; #Summary行に出力
write; #フォーマットに従って出力する。Summary行は長いので最後に...が表示される
print "</PRE></BODY></HTML>";
