#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$_ = "abracadabra"; #�����Ώە������$_�ɑ��
$count = s/ab/AB/;  #������u��
print $count;       #�u�����o�́B���ʁF1
print "\n";
print $_;           #������o�́B���ʁFABracadabra
print "\n";
$count = s/a/A/g;   #������u���Bg�C���q�ł��ׂĒu��
print $count;       #�u�����o�́B���ʁF4
print "\n";
print $_;           #������o�́B���ʁFABrAcAdAbrA
print "\n";
$count = s/a/^/ig;  #������u���Bi�C���q�ő啶������������
print $count;       #�u�����o�́B���ʁF5
print "\n";
print $_;           #������o�́B���ʁF^Br^c^d^br^
print "</PRE></BODY></HTML>";
