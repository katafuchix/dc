#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sub a{
  my $a;            #���[�J���ϐ�
  our $b;           #�O���[�o���ϐ�
  BEGIN{            #1�x�����l��������
    $a = 10;$b = 10;$c = 10; #$c���O���[�o���ϐ�
  }
  $a++;$b++;$c++;   #�C���N�������g
  print '$a=',$a;   #���[�J���ϐ���2��ڂɂ͒l�������B���ʁF11 , 1 , 1
  print "\n";
  print '$b=',$b;   #�O���[�o���ϐ��͒l��ۂ�������B���ʁF11,12,13
  print "\n";
  print '$c=',$c;   #�O���[�o���ϐ��͒l��ۂ�������B���ʁF11,12,13
  print "\n";
}
&a;&a;&a;           #3��Ăяo��
print "</PRE></BODY></HTML>";
