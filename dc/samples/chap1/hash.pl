#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
%hash = ("Sunday"=>"��",   #�A�z�z��ϐ��̏�����
         "Monday"=>"��",   #�L�[�ɕ�������g�p
         "Tuesday"=>"��");
%hash2 = (0,"��",          #�ʂ̏��������@
          1.2,"��",        #�L�[�ɐ��l���g�p
          2,"��");
print scalar %hash;        #�v�f���A�̈�T�C�Y���o�́B���ʁF3/8
print "\n";
print $hash{"Sunday"};     #�L�["Sunday"�̒l���o�́B���ʁF��
print "\n";
print $hash2{0};           #�L�[0�̒l���o�́B���ʁF��
print "\n";
print $hash2{1.2};         #�L�[1.2�̒l���o�́B���ʁF��
$hash{"Monday"} = "���j��";#�L�["Monday"�̒l��ύX
print "\n";
foreach $key(keys %hash){  #�A�z�z��̃L�[������$key�ɑ���B�悭�g����p�^�[��
  print $key;              #�A�z�z��̃L�[�ƒl�����ɏo��
  print $hash{$key};       #���ʁFTuesday �� Sunday �� Monday ���j��
}
print "\n";
@list = @hash{"Sunday","Tuesday"};
#�n�b�V���X���C�X���g�p���A�A�z�z���2�̒l���擾���Ĕz��ɑ��
foreach $i(@list){  #�z��̒l������$i�ɑ��
  print $i;         #�l�����ɏo�́B���ʁF����
}
print "</PRE></BODY></HTML>";
