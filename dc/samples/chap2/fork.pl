#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $ret = fork;       #fork��2�v���Z�X�ɕ���
if($ret != 0){        #�v���Z�XID��0���ǂ����Őe�q����������
  print "�e�v���Z�X";
}else{
  print "�q�v���Z�X";
} #���ʁF�q�v���Z�X �e�v���Z�X
print "</PRE></BODY></HTML>";
