#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = 1;       #�X�J���ϐ��ɐ��l���i�[
$b = "3";     #�X�J���ϐ��ɕ�������i�[
$c = $a + $b; #+���Z�q�͐��l�R���e�L�X�g�����̂�$b�͐��l�ɕϊ������
print $c;     #���ʁF4
print "\n";
$d = $a.$b;   #.���Z�q�͕�����R���e�L�X�g�����̂�$a�͕�����ɕϊ������
print $d;     #���ʁF13
print "\n";
$e = 3.1415;  #�X�J���ϐ��ɕ��������_�����i�[
$f = 1.2e+5;  #�X�J���ϐ��ɕ��������_���i�w���\�L�j���i�[
$g = \$a;     #�X�J���ϐ��Ƀ��t�@�����X���i�[
$h = $a + $e; #�����ƕ��������_���̉��Z�B���������_�Ƃ��Čv�Z�����
print $h;     #���ʁF4.1415
print "</PRE></BODY></HTML>";
