#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 0;         #���[�v�p�̕ϐ�
while($val < 10){ #10�񃋁[�v����while��
  $val++;         #�C���N�������g
  if($val < 5){   #5�����̏ꍇ��
    next;         #���̃��[�v��
  }
  print $val;     #�l�o�́B���ʁF5678910
}
print "\n";
@values = (0..4); #�z���`
foreach $value (@values){        #���ɒl�����o��
  if($value < 2){                #2�����Ȃ�
    next;                        #���̃��[�v�ցB������continue�u���b�N����������
  }
  print $value;                  #�l�o��
}continue{                       #���[�v������ɖ��񏈗�
  print "next";
}#���ʁFnextnext2next3next4next
print "</PRE></BODY></HTML>";
