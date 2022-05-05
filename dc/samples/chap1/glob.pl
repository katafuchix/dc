#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$var = "value";     #スカラ変数
@var = (1,2,3,4,5); #配列変数
%var = ("key1"=>"value1","key2"=>"value2"); #連想配列変数
*zzz = *var;        #型グロブを他の型グロブに代入
print $zzz;         #実際には$varの値を出力。結果：value
print "\n";
print @zzz;         #実際には@varの値を出力。結果：12345
print "\n";
print %zzz;         #実際には%varの値を出力。結果：key2value2key1value1
print "\n";
*CONSTVALUE = \10;  #スカラのリファレンスを型グロブに代入。定数値作成
*CONSTVALUE = [1,2,3,4,5]; #リストのリファレンスを型グロブに代入。定数値作成
print $CONSTVALUE;  #スカラ値出力。結果：10
print "\n";
print @CONSTVALUE;  #リスト値出力。結果：12345
print "</PRE></BODY></HTML>";
