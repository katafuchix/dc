#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@list = (1..5);      #�z��ϐ����`����1,2,3,4,5�łȂ郊�X�g����
print scalar @list;  #�z��̃T�C�Y���o�́B���ʁF5
print "\n";
print $list[0];      #�z���0�Ԗڂ��o�́B���ʁF1
print "\n";
$list[0] = 6;        #�z���0�Ԗڂɑ��
foreach $i (@list){  #�z��̒l������$i�ɑ��
  print $i;          #�z��̒l�����ɏo�́B���ʁF62345
}
print "\n";
@list2 = @list[2,3,4];#�z���2�A3�A4�Ԗڂ����X�g�Ƃ��Ď擾���ĕʂ̔z��ɑ��
foreach $i (@list2){ #�z��̒l������$i�ɑ��
  print $i;          #�z��̒l�����ɏo�́B���ʁF345
}
print "\n";
@list3 = @list[0..2];#�z���0�`2�Ԗڂ����X�g�Ƃ��Ď擾���ĕʂ̔z��ɑ��
foreach $i (@list3){ #�z��̒l������$i�ɑ��
  print $i;          #�z��̒l�����ɏo�́B���ʁF623
} 
print "\n";
@list[2,3] = (0,-1); #�z���2,3�Ԗڂ�ʂ̃��X�g�ɕύX
foreach $i (@list){  #�z��̒l������$i�ɑ��
  print $i;          #�z��̒l�����ɏo�́B���ʁF6 2 0 -1 5
}
print "\n";
print $#list;        #�z��̃C���f�b�N�X������o�́B���ʁF4
print "\n";
$#list = 2;          #�z��̃C���f�b�N�X�����2�ɕύX
foreach $i (@list){  #�z��̒l������$i�ɑ��
  print $i;          #�z��̒l�����ɏo�́B���ʁF620
} #�C���f�b�N�X3����ɂ�����-1,5�͔j������Ă���
print "</PRE></BODY></HTML>";
