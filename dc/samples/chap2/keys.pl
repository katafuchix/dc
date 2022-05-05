#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
%days = ("Sunday" => "日","Monday" => "月","Tuesday"=>"火");
$nKey = keys %days;         #スカラコンテキストでキー個数取得
print $nKey;                #キーの個数。結果：3
print "\n";
@daysKey = keys %days;      #リストコンテキストでキー一覧取得
foreach $str (@daysKey){
  print $str;               #キーの一覧。結果：TuesdayMondaySunday
}
print "\n";
$nValues = values %days;    #スカラコンテキストで値の個数取得
print $nValues;             #値の個数。結果：3
print "\n";
@daysValues = values %days; #リストコンテキストで値一覧取得
foreach $str (@daysValues){
  print $str;               #値の一覧。結果：火日月
}
print "</PRE></BODY></HTML>";
