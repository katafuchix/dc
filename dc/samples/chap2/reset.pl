#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $aa = 1;    #my�Ń��[�J���ϐ�
local $ab = 2; #local�Ń��[�J���ϐ�
$ac = 3;       #�O���[�o���ϐ�
print $aa;     #���ʁF1
print "\n";
print $ab;     #���ʁF2
print "\n";
print $ac;     #���ʁF3
print "\n";
reset 'a';     #a�Ŏn�܂邷�ׂẴO���[�o���ϐ���������
print $aa;     #���������ꂸ�B���ʁF1
print "\n";
print $ab;     #�����������B���ʁF�i�Ȃ��j
print "\n";
print $ac;     #�����������B���ʁF�i�Ȃ��j
print "\n";
print $ENV{"temp"}; #temp���ϐ����o�́B���ʁFc:\temp
print "\n";
reset 'A-Z';   #@ARGV,@INC,%ENV���܂߂ď���������̂Ŋ댯
print $ENV{"temp"}; #temp���ϐ����o�́B���ʁF�i�Ȃ��j
 #%ENV�̓��e�܂ŏ���������Ă���
print "</PRE></BODY></HTML>";
