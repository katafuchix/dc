#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print scalar localtime;  #���ݎ����B���ʁFFri Jan  6 04:08:35 2006
print "\n";
print join ",",localtime;#���X�g���e�B���ʁF35,8,4,6,0,106,5,5,0
print "</PRE></BODY></HTML>";
