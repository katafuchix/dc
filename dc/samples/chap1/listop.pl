#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print 1,2,sort 4,3;       #print、sortはリスト演算子。結果：1234
print "\n";
print 1,2,(sort 4,3);     #上行と同じ処理。結果：1234
print "\n";
print 1,2+3,4;            #printは右方向リスト演算子。結果：154
print "\n";
print (1,(2+3),4);        #上行と同じ処理。結果：154
print "\n";
print 1,2,3 and print "a";#and演算子を使う
print "\n";
(print 1,2,3) and (print "a");#上行と同じ処理。結果：123a
print "\n";
print 1,2,3 && print "a";  #&&演算子を使う。結果：a121
print "\n";
print 1,2,(3 && print "a");#上行と同じ処理。予想と異なる処理順。結果：a121
#print "a"でa出力、1、2出力、最後に3と(print "a")の戻り値の&&演算子処理で1を出力
print "</PRE></BODY></HTML>";
