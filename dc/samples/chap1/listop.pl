#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print 1,2,sort 4,3;       #print�Asort�̓��X�g���Z�q�B���ʁF1234
print "\n";
print 1,2,(sort 4,3);     #��s�Ɠ��������B���ʁF1234
print "\n";
print 1,2+3,4;            #print�͉E�������X�g���Z�q�B���ʁF154
print "\n";
print (1,(2+3),4);        #��s�Ɠ��������B���ʁF154
print "\n";
print 1,2,3 and print "a";#and���Z�q���g��
print "\n";
(print 1,2,3) and (print "a");#��s�Ɠ��������B���ʁF123a
print "\n";
print 1,2,3 && print "a";  #&&���Z�q���g���B���ʁFa121
print "\n";
print 1,2,(3 && print "a");#��s�Ɠ��������B�\�z�ƈقȂ鏈�����B���ʁFa121
#print "a"��a�o�́A1�A2�o�́A�Ō��3��(print "a")�̖߂�l��&&���Z�q������1���o��
print "</PRE></BODY></HTML>";
