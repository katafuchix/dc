#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
%days = ("Sunday" => "��","Monday" => "��","Tuesday"=>"��");
while($str = each %days){       #�L�[�����Ɏ��o��
  print $str;                   #���ʁFTuesday Monday Sunday
}#while�X�e�[�g�����g�͋󃊃X�g�ŏI������
print "\n";
 #�����each�֐����Ăяo���Ɛ擪�ɖ߂�
while(($str,$val) = each %days){#�L�[�ƒl���Z�b�g�Ŏ��o��
  print $str.":".$val;          #���ʁFTuesday:�� Monday:�� Sunday:��
}
print "\n";
while(($str,$val) = each %days){#�L�[�ƒl���Z�b�g�Ŏ��o��
  $val = $val."�j��";   #�l������������
}
while(($str,$val) = each %days){#�L�[�ƒl���Z�b�g�Ŏ��o��
  print $str.":".$val;          #���̒l�͏��������Ȃ�
}
print "</PRE></BODY></HTML>";
