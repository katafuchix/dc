#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print ("a","b",10);  #3�̗v�f����ׂ����X�g���o�́B���ʁFab10n
print "\n";
@list = (1,2,3,4,5); 
print @list;         #�z��̗v�f����ׂ����X�g���o�́B���ʁF12345
print "\n";
%hash = ("key1"=>"value1","key2"=>"value2");
print %hash;#�A�z�z��̃L�[�Ɨv�f�����݂ɕ��ׂ����X�g���o��
#���ʁFkey2value2key1value1
print "\n";
print (@list,%hash,"c"); #�z��list�̗v�f�A�A�z�z��hash�̃L�[�ƒl��
                         #���݂ɕ��ׂ����X�g�A"c"�����ɘA���������X�g��Ԃ�
#���ʁF12345key2value2key1value1c
print "\n";
while(($key,$value) = each %hash){ #�A�z�z��̃L�[�ƒl��$key��$value�ɏ��ɑ��
  print "$key:$value";   #�L�[�ƒl���o�́B���ʁFkey2:value2 key1:value1
}
print "</PRE></BODY></HTML>";
