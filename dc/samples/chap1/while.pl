#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 0;
while($val <= 5){               #�������ŏ��ɕ]�����A�^�̊ԃ��[�v
  print $val;                   #���ʁF012345
  $val++;                       #�C���N�������g
} continue {                    #�u���b�N������ɖ��񏈗������
  print $val;                   #���ʁF123456
} #���ۂɂ�3�s�ڂ�print����6�s�ڂ�print�������݂ɌĂ΂��̂Ō��ʂ�011223344556
print "\n";
$val = 0;
print $val++ while ($val <= 5); #��Ɠ��l�B���ʁF012345
print "\n";
$val = 10;
print $val++ while ($val <= 5); #�ŏ�������������U�Ȃ̂ŕ��͏�������Ȃ�
print "\n";
do {                            #�������̕]������Ƀu���b�N��1�񏈗�����
  print $val;                   #���ʁF10
  $val++;
}while ($val <= 5);             #�������͋U�Ȃ̂Ń��[�v�͂��Ȃ�
#while(1){                       #�������[�v
#  print "a";                    #���ʁFaaaaaaaaa...
#}
print "</PRE></BODY></HTML>";
