#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 0;
while(1){                #�������[�v
  print $val++;          #�C���N�������g���l���o�́B���ʁF01234
  if($val == 5){         #�l��5�ɂȂ�����
    last;                #���[�v�����I��
  }
}
print "\n";
while(<STDIN>){          #���͂�ǂݍ���
  if(/^quit$/){          #quit�Ɠ��͂����
    last;                #�������I������
  }
  print $_;              #����ȊO�͓��͂��ꂽ�������o�͂���
}
print "</PRE></BODY></HTML>";
