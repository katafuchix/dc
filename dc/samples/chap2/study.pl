#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$_ = "abcdefghijk 12345 abcdefg"x1000000; #���ɒ���������
$time = time;     #���ԋL�^
for(0..10000000){ #10000000�񃋁[�v
  while(m/cde/g){ #"cde"��m//g�T�[�`
  }
}
$time2 = time;    #���ԋL�^
print $time2 - $time; #study�֐������̌��ʁB���ʗ�F25
print "\n";
study;            #$_�ɑ΂��Ă̊w�K���s��
for(0..10000000){ #10000000�񃋁[�v
  while(m/cde/g){ #"cde"��m//g�T�[�`
  }
}
$time3 = time;    #���ԋL�^
print $time3 - $time2; #study�֐��L��̌��ʁB���ʗ�F21
print "</PRE></BODY></HTML>";
