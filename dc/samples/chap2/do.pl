#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print do {my $val = 2 * 4;my $val2 = $val + 2}; #�Ō�̎��̌��ʂ��Ԃ�B���ʁF10
print "\n";
print do sampleSub();                 #�T�u���[�`���̕Ԓl���Ԃ�B���ʁF12
print "\n";
do "other.pl";                        #���̃t�@�C���̓��e�����s����
 #���ʁFOther script
sub sampleSub{                        #�T�u���[�`����B12��Ԃ�
  return 3 * 4;
}
print "</PRE></BODY></HTML>";
