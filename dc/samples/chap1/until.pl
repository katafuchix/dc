#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 0;
until($val > 5){                #�������ŏ��ɕ]�����A�U�̊ԃ��[�v
  print $val;                   #���ʁF012345
  $val++;                       #�C���N�������g
}
print $val++ until ($val > 3); #�ŏ�������������^�Ȃ̂ŕ��͏�������Ȃ�
print "</PRE></BODY></HTML>";
