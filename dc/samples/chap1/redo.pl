#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"sample.txt"; #�t�@�C�����J��
while(<INFILE>){          #��s���ǂݏo��
  if(/\n$/){              #�s�̖��������s�����̏ꍇ��
    chomp;                #���s������؂藎�Ƃ�
    $_ .= <INFILE>;       #���̍s�ƌ�������
    redo;                 #�擪���珈��������
  }
  print $_;               #�t�@�C�����e���ׂĂ�1�s�ɘA�����ďo��
}
print "\n";
for($val = 0 ; $val < 10 ; $val++){
  print $val;             #�l�o�́B���ʁF012345555555555...
  if($val == 5){          #�l��5�̏ꍇ��
#    redo; #���̃��[�v�ցB����������������Ȃ��̂Ŗ������[�v�ɂȂ�
  }
}
print "</PRE></BODY></HTML>";
