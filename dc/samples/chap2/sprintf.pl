#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print sprintf "abcde\n";    #���߈ȊO�̕�����͂��̂܂܏o�͂����B���ʁFabcde
print sprintf "%04d\n",2;   #�擪��0��t���čŏ���4���B���ʁF0002
print sprintf "%+d\n",10;   #�擪��+��t����B���ʁF+10
print sprintf "%-4d\n",10;  #���l�B���ʁF10
print sprintf "%4d\n",10;   #�E�l�B���ʁF  10
print sprintf "%#o\n",10;   #8�i���Ő擪��0��t����B���ʁF012
print sprintf "%s\n","abcde";#������o�́B���ʁFabcde
print sprintf "%5s\n","cde";#������ōŏ���5���B�擪�ɋ󔒒ǉ��B���ʁF  cde
print sprintf "%.5s\n","abcdefg";#������ōő啝5��
 #�����񂪓r���܂ł����o�͂���Ȃ��B���ʁFabcde
printf "%8.3f\n", 3.1415;   #8�������_�ȉ�3���B���ʁF   3.142
$value1 = 10;
$value2 = 20;
print sprintf "value1 is %d. value2 is %d\n",$value1,$value2; #�����̒l���w��
 #���ʁFvalue1 is 10. value2 is 20
print "</PRE></BODY></HTML>";
