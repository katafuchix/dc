#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 10;            #�X�J���ϐ�
$refval = \$val;      #���t�@�����X���X�J���ϐ��ɑ��
print $$refval;       #���ʎq$��t���ĎQ�ƁB���ʁF10
print "\n";
@list = (1,2,3,4,5);  #�z��ϐ�
$reflist = \@list;    #���t�@�����X���X�J���ϐ��ɑ��
print $reflist->[2];  #�A���[���Z�q�ŎQ�ƁB���ʁF3
print "\n";
%hash = ("Sunday" => "��","Monday" => "��","Tuesday"=>"��"); #�A�z�z��ϐ�
$refhash = \%hash;           #���t�@�����X���X�J���ϐ��ɑ��
foreach $i (keys %$refhash){ #���ʎq%��t���ĎQ�ƁB
  print $i;                  #���ʁFTuesdayMondaySunday
}
print "\n";
$reflist2 = [5..9];          #���X�g�̃��t�@�����X���X�J���ϐ��ɑ��
print @$reflist2;            #���ʎq@��t���ĎQ�ƁB���ʁF56789
print "</PRE></BODY></HTML>";
