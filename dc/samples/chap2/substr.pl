#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $str1 = "ABCDEFG";
print substr($str1,2);   #2�����ڈȍ~�؂�o���B���ʁFCDEFG
print "\n";
print substr($str1,2,3); #2�����ڂ���3�����؂�o���B���ʁFCDE
print "\n";
print substr($str1,-2);  #��������2�����ڈȍ~�؂�o�� ���ʁFFG
print "\n";
print substr($str1,2,-2);#2�����ځ`��������2�����ڂ܂Ő؂�o�� ���ʁFCDE
print "\n";
print substr($str1,4,-4);#4�����ځ`��������4�����ڂ܂Ő؂�o���B
                         #�͈͂���������̂Ő؂�o���Ȃ� ���ʁF�󕶎���
print "\n";
my $str2 = substr($str1,2,2,"xyz"); #2�����ڂ���2��������u���B
print $str1;             #�u�����ʕ�����B���ʁFABxyzEFG
print "\n";
print $str2;             #�u���Ώە����񂪕Ԃ�B���ʁFCD
print "\n";
$str1 = "ABCDEFG";       #$str1�����ɖ߂�
substr($str1,2) = ".";   #2�����ڈȍ~��u��
print $str1;             #���ʁFAB.
print "\n";
$str1 = "ABCDEFG";       #$str1�����ɖ߂�
substr($str1,2,3) = "-"; #2�����ڂ���3�����u��
print $str1;             #���ʁFAB-FG
print "</PRE></BODY></HTML>";
