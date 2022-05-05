#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
%days = ("Sunday" => "日","Monday" => "月","Tuesday"=>"火");
if(exists $days{"Sunday"}){
  print "存在する";            #キー"Sunday"は存在。結果：存在する
}
print "\n";
if(not exists $days{"Friday"}){
  print "存在せず";            #キー"Friday"は存在しない。結果：存在せず
}
print "</PRE></BODY></HTML>";
