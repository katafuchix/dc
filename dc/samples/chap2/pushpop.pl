#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
for($i = 0 ; $i < 5 ; $i++){
  push @array,$i;           #�z��ɗv�f��1���ǉ�
}#�z�����0,1,2,3,4�̏�
@array2 = (a,b,c);
push @array,@array2;        #�z��ɔz���ǉ�
$num = $#array + 1;         #�z��̗v�f���擾�B�ő�C���f�b�N�X�{1
for($j = 0 ; $j < $num + 1 ; $j++){ #�킴��1�񑽂����[�v������
  $val = pop @array;
  print $val;               #���ʁF4321abc0
  if($val eq undef){        #�Ō�̃��[�v�ł�
    print "underflow";      #�z�񂪋�Ȃ̂�undef���Ԃ�B���ʁFundeflow
  }
}
print "</PRE></BODY></HTML>";
