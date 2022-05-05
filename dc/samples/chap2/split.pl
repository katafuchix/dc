#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $str = "This is a pen.";
my @list = split / /,$str;      #半角スペースで分割してリスト変数に代入
foreach $i (@list){
  print $i."\n";                #結果（1行ごとに)："This","is","a","pen."
}
my $number = split / /,$str;    #半角スペースで分割してスカラ変数に代入
print $number;                  #結果：4
print "\n";
my @list2 = split / /,$str,2;   #最大分割数2で分割してリスト変数に代入
foreach $j (@list2){
  print $j."\n";                #結果（一行ごとに)："This","is a pen."
}                               #2つ目以降の分割が行われていない
my @list3 = split /( )/,$str;   #パターンも含めて分割してリスト変数に代入
foreach $k (@list3){
  print $k."\n";                #結果："This"," ","is"," ","a"," ","pen."
}                               #パターンである半角スペースも結果に含まれる
my $number3 = split /( )/,$str; #パターンも含めて分割してスカラ変数に代入
print $number3;                 #結果：7
print "</PRE></BODY></HTML>";
