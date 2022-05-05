#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $aa = 1;    #myでローカル変数
local $ab = 2; #localでローカル変数
$ac = 3;       #グローバル変数
print $aa;     #結果：1
print "\n";
print $ab;     #結果：2
print "\n";
print $ac;     #結果：3
print "\n";
reset 'a';     #aで始まるすべてのグローバル変数を初期化
print $aa;     #初期化されず。結果：1
print "\n";
print $ab;     #初期化される。結果：（なし）
print "\n";
print $ac;     #初期化される。結果：（なし）
print "\n";
print $ENV{"temp"}; #temp環境変数を出力。結果：c:\temp
print "\n";
reset 'A-Z';   #@ARGV,@INC,%ENVも含めて初期化するので危険
print $ENV{"temp"}; #temp環境変数を出力。結果：（なし）
 #%ENVの内容まで初期化されている
print "</PRE></BODY></HTML>";
