#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
%days = ("Sunday" => "日","Monday" => "月","Tuesday"=>"火");
my $val = delete $days{"Monday"}; #キー"Monday"を削除
print $val;                       #削除された値。結果：月
print "\n";
@array = (0..4);
print delete $array[2];           #配列のインデックスが2の要素を削除。結果2
print "\n";
foreach(@array){
  print;                          #配列内容出力。結果0134
}
print "</PRE></BODY></HTML>";
