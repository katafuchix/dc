#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
for($i = 0 ; $i < 5 ; $i++){
  unshift @array,$i;        #�z��擪�ɗv�f��1���ǉ�
}#�z�����4,3,2,1,0�̏�
@array2 = (a,b,c);
unshift @array,@array2;     #�z��擪�ɔz���ǉ�
$num = $#array + 1;         #�z��̗v�f���擾�B�ő�C���f�b�N�X�{1
for($j = 0 ; $j < $num + 1 ; $j++){ #�킴��1�񑽂����[�v������
  $val = shift @array;
  print $val;               #���ʁFabc43210
  if($val eq undef){        #�Ō�̃��[�v�ł�
    print "underflow";      #�z�񂪋�Ȃ̂�undef���Ԃ�B���ʁFundeflow
  }
}
print "</PRE></BODY></HTML>";
