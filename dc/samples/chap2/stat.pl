#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@list = stat "sample.txt";       #sample.txt�̏��擾
for(0..12){                      #0-12�܂Ŗ߂�l�̓��e���o��
  print "$_:";
  unless($_ >= 8 && $_<=10){     #8-10�ȊO�͂��̂܂܏o��
    print $list[$_];
  }else{                         #8-10�̏ꍇ��
    print scalar localtime($list[$_]); #localtime�֐��ŕϊ�
  }
  print "\n";
}
print "</PRE></BODY></HTML>";
