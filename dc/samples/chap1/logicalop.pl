#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = "Hello";
$b = "World";
$c = undef;
print $a && $b;    #�_���ρB���ʁFWorld�i�E���̍��̒l�j
print "\n";
print $a and $c;   #and�̗D�揇�ʂ��ア�̂�(print $a) and $b�ƕ]�������
                   #���ʁFHello�i�����̍��̒l�j
print "\n";
print ($a and $c); #���Z�����𖾎����Ę_���ρB���ʁF�i�Ȃ��F�E���̍��̒l�j
print "\n";
print $a || &B;    #�T�u���[�`��B�͌Ă΂Ȃ��B���ʁFHello�i�����̍��̒l�j
print "\n";
print $c or &B;    #and�̗D�揇�ʂ��ア�̂�(print $c) and &B�ƕ]�������
                   #���ʁFSub B�iundef�Ȃ̂ŉ����o�͂����A���̌�B�Ăяo���j
print "\n";
print ($c or &B);  #���Z�����𖾎��BB�͌Ă΂Ȃ��B���ʁFHello�i�����̍��̒l�j
$d = 1;
$e = 0;
print ($d xor $e);   #�r���_���a�B���ʁF1�i�����̍��̒l�j
print "\n";
print ($e xor $d);   #�r���_���a�B���ʁF1�i�E���̍��̒l�j
print "\n";
print ($e xor $e);   #�r���_���a�B���ʁF�i�Ȃ��Fundef�j
print "\n";
print ($d xor $d);   #�r���_���a�B���ʁF�i�Ȃ��Fundef�j
sub B{
  print "Sub B";
  return "World";
}
$a = "hello";
$b = undef;
print !$a;    #���ʁF�i�Ȃ��j
print "\n";
print not $a; #���ʁF�i�Ȃ��j
print "\n";
print !$b;    #���ʁF1
print "\n";
print not $b; #���ʁF1
print "</PRE></BODY></HTML>";
