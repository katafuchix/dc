#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print 6 ^ 3; #110 & 011�B���ʁF5�i101�j
print "\n";
print "6" & "b"; #00110110 & 01100010
#�i�����Ƃ�������Ȃ̂ŕ�����Ƃ��ăr�b�g���Ƃɔ�r�j�B���ʁF"�i00100010�j
print "\n";
print "aa" & "ab"; #01100001 01100001 & 01100001 01100010
#���ʁFa`�i01100001 01100000�j
print "\n";
print ~6; #00000000000000000000000000000110�̃r�b�g�ے�B���ʁF4294967289
print "\n";
print 5 << 2; #��2�r�b�g�V�t�g�B5 * 2 * 2�B���ʁF20
print "\n";
print 5 >> 1; #�E1�r�b�g�V�t�g�B00000101��00000010�B���ʁF2
print "</PRE></BODY></HTML>";
