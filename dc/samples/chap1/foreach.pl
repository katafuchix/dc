#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@values = (0,1,2,3,4,5,6,7,8,9);    #�z���`
foreach $value (@values){           #�z��̗v�f�����Ɏ��o����$value�ɑ��
  print $value;                     #�v�f���o�́B���ʁF0123456789
}
print "\n";
foreach $value (@values){           #��Ɠ��l
  print $value;
}continue{                          #���[�v������ɖ��񏈗�
  print "next";                     #���ʁFnextnextnext....
} #���ۂɂ�6�s�ڂ�8�s�ڂ����݂ɏ��������B���ʁF0next1next2next3next...
print "\n";
%days = ("Sunday" => "��",          #�A�z�z���`
         "Monday" => "��",
         "Tuesday"=>"��");
foreach $str (values %days){        #�A�z�z��̒l�����Ɏ��o����$str�ɑ��
  print $str;                       #�l���o�́B���ʁF�Γ���
}
print "</PRE></BODY></HTML>";
