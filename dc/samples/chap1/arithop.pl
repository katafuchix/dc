#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = 5;
$b = 3;
print $a + $b;      #���Z�B���ʁF8
print "\n";
print $a - $b;      #���Z�B���ʁF2
print "\n";
print $a * $b;      #��Z�B���ʁF15
print "\n";
print $a / $b;      #���Z�B���ʁF1.66666666666667
print "\n";
print $a % $b;      #���Z�̗]��B���ʁF2
print "\n";
print $a ** $b;     #�ׂ���B���ʁF125
print "\n";
print "3fskj" + "423fds";  #������̐擪�𐔒l�Ƃ݂Ȃ��ĉ��Z�B���ʁF426
print "\n";
print "43jfkew" - "fgrwe"; #�擪�ɐ������Ȃ��ꍇ��0�Ƃ݂Ȃ��B���ʁF43
print "\n";
print int($a / $b); #���Z�̏��B���ʁF1
print "\n";
print 10.5 / 3.8;   #�����_�̏��Z�B���ʁF2.76315789473684
print "\n";
print 10.5 % 3.8;   #�����_�̏��Z�̗]��B���ʁF1
print "\n";
#print 2 / 0;        #0�ŏ��Z�B��O����
#���ʁFIllegal division by zero at C:\src\chap1\arithop.pl line 14.
#print 2 % 0;        #0�ŏ��Z�̗]��B��O����
#���ʁFIllegal modulus zero at C:\src\chap1\arithop.pl line 16.
print 100000000000 ** 10000000000; #�����ӂ�B���ʁF1.#INF
print "\n";
$a = -5;
$b = 3;
print +$a; #+���Z�q���g�p���邪���ʂ͂Ȃ��B���ʁF-5
print "\n";
print -$a; #-���Z�q�ŕ����𔽓]������B���ʁF5
print "\n";
print -$b; #-���Z�q�ŕ����𔽓]������B���ʁF-3
print "</PRE></BODY></HTML>";
