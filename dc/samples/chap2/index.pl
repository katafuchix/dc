#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$string = "hogehoge";
$substr1 = "ge"; #�������镶����B#2,6�����ڂɌ�����͂�
print index $string,$substr1;     #�擪���猟���B���ʗ�F2
print "\n";
print rindex $string,$substr1;    #�������猟���B���ʗ�F6
print "\n";
print index $string,$substr1,3;   #�擪����3�����ڂ��猟���B���ʗ�F6
print "\n";
print rindex $string,$substr1,3;  #��������3�����ڂ��猟���B���ʗ�F2
print "\n";
$substr2 = "oh";                  #�������镶����B������Ȃ��͂�
print index $string,$substr2;     #�������s�B���ʗ�F-1
print "</PRE></BODY></HTML>";
