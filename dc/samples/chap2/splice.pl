#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@array = (1,2,3,4,5,6);
@subarray = splice @array,2,2;    #3�Ԗڂ���2��菜��
&printarray(@subarray);           #���ʁF34
@array = (1,2,3,4,5,6);
@subarray = splice @array,-5,-2;  #��������5�Ԗڂ��疖������3�Ԗڂ܂Ŏ�菜��
&printarray(@subarray);           #���ʁF234
@array = (1,2,3,4,5,6);
my @newarray = (a,b,c);
splice @array,2,2,@newarray;      #3�Ԗڂ���2��ʂ̔z��Œu���B�������ω�����
&printarray(@array);              #���ʁF12abc56
sub printarray{                   #�z��̓��e���o�͂���T�u���[�`��
  foreach $i (@_){
    print $i;
  }
  print "\n";
}
print "</PRE></BODY></HTML>";
