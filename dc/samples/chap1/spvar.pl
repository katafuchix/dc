#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@list = (1,2,3,4,5);#�z���`
foreach (@list){    #�ȗ��L�@�B@list�̗v�f��1����$_�ɑ��
  print;            #�ȗ��L�@�B$_�̓��e���o�́B���ʁF12345
}
print "\n";
foreach $i (@list){ #�ȗ����Ȃ��L�@�B@list�̗v�f��1����$i�ɑ��
  print $i;         #�ȗ����Ȃ��L�@�B$i�̓��e���o�́B���ʁF12345
}
print "\n";
for (1..5){         #�ȗ��L�@�B$_��1����5�܂ŕς��Ȃ��烋�[�v
  print;            #�ȗ��L�@�B$_�̓��e���o�́B���ʁF12345
}
print "\n";
for ($i = 1 ; $i <=5 ; $i++){ #�ȗ����Ȃ��L�@�B$i��1����5�܂ŕς��Ȃ��烋�[�v
  print $i;         #�ȗ����Ȃ��L�@�B$i�̓��e���o�́B���ʁF12345
}
print "</PRE></BODY></HTML>";
