#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
eval {
  local $SIG{ALRM} = sub { die "alarm\n" }; #SIGALRM��M����alarm\n�𑗏o����die
  alarm 3;                                  #3�b��ɃA���[���ݒ�
  sleep 10;                                 #���Ԃ̂����鏈��
  alarm 0;                                  #�A���[������
};
if($@){     #eval���ɃG���[�����������ꍇ
  print $@; #���b�Z�[�W�o�́Balarm�������ł���Ό��ʁFalarm
}
print "</PRE></BODY></HTML>";
