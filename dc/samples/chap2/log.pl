#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print log 2;                         #2�̎��R�ΐ��B���ʁF0.693147180559945
print "\n";
print log exp 1;                     #e�̎��R�ΐ��B���ʁF1
print "\n";
print logn(8,2);                     #2���Ƃ���8�̑ΐ��B���ʁF3
sub logn { log($_[0]) / log($_[1]) } #n���Ƃ���ΐ��v�Z�T�u���[�`��
print "</PRE></BODY></HTML>";
