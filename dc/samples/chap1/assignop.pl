#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = 4;
$b = 3;
$a += $b; #$a = $a + $b�Ɠ���
print $a; #4 + 3�B���ʁF7
print "\n";
$a *= $b; #$a = $a * $b�Ɠ���
print $a; #7 * 3�B���ʁF21
print "\n";
$c = "Hello";
$d = "World";
$c .= $d; #$c = $c . $d�B������A��
print $c; #���ʁFHelloWorld
print "\n";
$d x= 3;  #$d��3��J��Ԃ��đ��
print $d; #���ʁFWorldWorldWorld
print "\n";
$e = 5;   #2�i����101
$f = 10;  #2�i����1001
$e |= $f; #$e = $e | $f
print $e; #�r�b�g�_���a�̌��ʂ�1111�B���ʁF15�i1111�j
print "</PRE></BODY></HTML>";
