#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use SDBM_File;     #DBM�t�@�C�����J�����߂�SDBM_File���W���[����`��ǂݍ���
tie(%hash, 'SDBM_File', 'test', 1, 0);#"test"DBM�t�@�C�����J���ăo�C���h����
while (($key,$val) = each %hash) {    #�A�z�z�񂩂�v�f�擾
  print $key.'='.$val;                #�l�o�́B���ʁFtest=10
}
if(tied %hash){                       #�o�C���h����Ă����
  untie %hash;                        #�o�C���h����
}
print "</PRE></BODY></HTML>";
