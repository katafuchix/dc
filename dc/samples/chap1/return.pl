#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sub sub_a{           #���������Ȃ��T�u���[�`��
  if($val > 5){      #�O���[�o���ϐ�$val��5�����Ȃ�
    return $val;     #�������I������$val��Ԃ�
  }else{             #�����łȂ����
    return $val * 2; #$val��2�{��Ԃ�
  }
}
$val = 10;
print sub_a;         #sub_a�͏�Ő錾�ςȂ̂Őړ����͕s�v
#sub_a�̖߂�l��10�B���ʁF10
do &sub_a;           #do�֐����g���ČĂяo��
print "</PRE></BODY></HTML>";
