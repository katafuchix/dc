#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sub a{
  print "test";
}
$val = 10;
print $val; #���ʁF10
print "\n";
undef $val; #�ϐ��𖢒�`�ɂ���
print $val; #���ʁF�i�Ȃ��j
print "\n";
@list = (1,2,3);
print @list;#���ʁF1 2 3
undef @list;#�z��𖢒�`�ɂ���
print "\n";
print @list;#���ʁF�i�Ȃ��j
print "\n";
&a;         #���̎��_�ł͌Ăׂ�B���ʁFtest
undef &a;   #�T�u���[�`���𖢒�`�ɂ���
#&a;#���ʁFUndefined subroutine &main::a called at C:\src\chap3\undef.pl line 8.
#�������G���[���b�Z�[�W���ŏ��ɏo�͂����
print "</PRE></BODY></HTML>";
