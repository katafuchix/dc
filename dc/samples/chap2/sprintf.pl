#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print sprintf "abcde\n";    #命令以外の文字列はそのまま出力される。結果：abcde
print sprintf "%04d\n",2;   #先頭に0を付けて最小幅4桁。結果：0002
print sprintf "%+d\n",10;   #先頭に+を付ける。結果：+10
print sprintf "%-4d\n",10;  #左詰。結果：10
print sprintf "%4d\n",10;   #右詰。結果：  10
print sprintf "%#o\n",10;   #8進数で先頭に0を付ける。結果：012
print sprintf "%s\n","abcde";#文字列出力。結果：abcde
print sprintf "%5s\n","cde";#文字列で最小幅5桁。先頭に空白追加。結果：  cde
print sprintf "%.5s\n","abcdefg";#文字列で最大幅5桁
 #文字列が途中までしか出力されない。結果：abcde
printf "%8.3f\n", 3.1415;   #8桁小数点以下3桁。結果：   3.142
$value1 = 10;
$value2 = 20;
print sprintf "value1 is %d. value2 is %d\n",$value1,$value2; #複数の値を指定
 #結果：value1 is 10. value2 is 20
print "</PRE></BODY></HTML>";
