#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $str = "This is a pen.";
my @list = split / /,$str;      #���p�X�y�[�X�ŕ������ă��X�g�ϐ��ɑ��
foreach $i (@list){
  print $i."\n";                #���ʁi1�s���Ƃ�)�F"This","is","a","pen."
}
my $number = split / /,$str;    #���p�X�y�[�X�ŕ������ăX�J���ϐ��ɑ��
print $number;                  #���ʁF4
print "\n";
my @list2 = split / /,$str,2;   #�ő啪����2�ŕ������ă��X�g�ϐ��ɑ��
foreach $j (@list2){
  print $j."\n";                #���ʁi��s���Ƃ�)�F"This","is a pen."
}                               #2�ڈȍ~�̕������s���Ă��Ȃ�
my @list3 = split /( )/,$str;   #�p�^�[�����܂߂ĕ������ă��X�g�ϐ��ɑ��
foreach $k (@list3){
  print $k."\n";                #���ʁF"This"," ","is"," ","a"," ","pen."
}                               #�p�^�[���ł��锼�p�X�y�[�X�����ʂɊ܂܂��
my $number3 = split /( )/,$str; #�p�^�[�����܂߂ĕ������ăX�J���ϐ��ɑ��
print $number3;                 #���ʁF7
print "</PRE></BODY></HTML>";
