#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $ret = fork;       #fork��2�v���Z�X�ɕ���
if($ret != 0){        #�v���Z�XID��0���ǂ����Őe�q����������
  print $ret;         #�q�v���Z�XID�\���B���ʁF-4052
  print wait;         #�q�v���Z�X�I���҂��B���ʁF-4052
}else{
  exit;               #�q�v���Z�X���I��������
}
my $ret2 = fork;      #fork��2�v���Z�X�ɕ���
if($ret2 != 0){
  print waitpid $ret2,WNOHANG; #�q�v���Z�X���w�肵�ďI���҂�����B���ʁF-832
}
print "</PRE></BODY></HTML>";
