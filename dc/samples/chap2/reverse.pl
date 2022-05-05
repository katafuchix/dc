#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@array = (1,2,3,4,5,6);
@rarray = reverse @array;
&printarray(@rarray);      #並び替え。結果：654321
&printarray(@array);       #元配列は変化無し。結果：123456

my $str = "abcdef";
$rstr = reverse $str;
print $rstr;               #並び替え。結果：fedcba
print "\n";
print $str;                #元文字列は変化無し。結果：abcdef

sub printarray{            #配列の内容を出力するサブルーチン
  foreach $i (@_){
    print $i;
  }
  print "\n";
}
print "</PRE></BODY></HTML>";
