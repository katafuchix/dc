#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
%days = ("Sunday" => "��","Monday" => "��","Tuesday"=>"��");
if(exists $days{"Sunday"}){
  print "���݂���";            #�L�["Sunday"�͑��݁B���ʁF���݂���
}
print "\n";
if(not exists $days{"Friday"}){
  print "���݂���";            #�L�["Friday"�͑��݂��Ȃ��B���ʁF���݂���
}
print "</PRE></BODY></HTML>";
