#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $val = 4,my $val2 = 0;
print eval {$val = 2};   #�Ō�̕��̌��ʂ��Ԃ�B���ʁF2
eval {$val / $val2};     #0���Z�G���[����
print "\n";
if($@){                  #�G���[���b�Z�[�W�`�F�b�N
  print $@; #���ʁF2Illegal division by zero at C:\src\chap2\eval.pl line 3.
}
print "</PRE></BODY></HTML>";
