#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$password = "himitsu";              #�p�X���[�h
$key = "su";                        #�Í����L�[
$cryptkey = crypt $password,$key;
print $cryptkey;               #�Í������ꂽ������B���ʗ�Fsu.9vZqPON4OQ
$input = "himitsu";                 #�������p�X���[�h��
if($cryptkey eq crypt $input,$key){ #��������Í������ďƍ�
  print "�F�ؐ���";
}else{
  print "�F�؎��s";
}
print "</PRE></BODY></HTML>";
