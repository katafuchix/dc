#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
%days = ("Sunday" => "��","Monday" => "��","Tuesday"=>"��");
$nKey = keys %days;         #�X�J���R���e�L�X�g�ŃL�[���擾
print $nKey;                #�L�[�̌��B���ʁF3
print "\n";
@daysKey = keys %days;      #���X�g�R���e�L�X�g�ŃL�[�ꗗ�擾
foreach $str (@daysKey){
  print $str;               #�L�[�̈ꗗ�B���ʁFTuesdayMondaySunday
}
print "\n";
$nValues = values %days;    #�X�J���R���e�L�X�g�Œl�̌��擾
print $nValues;             #�l�̌��B���ʁF3
print "\n";
@daysValues = values %days; #���X�g�R���e�L�X�g�Œl�ꗗ�擾
foreach $str (@daysValues){
  print $str;               #�l�̈ꗗ�B���ʁF�Γ���
}
print "</PRE></BODY></HTML>";
