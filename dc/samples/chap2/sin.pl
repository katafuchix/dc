#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$pi = 3.14159265;                 #�΂̒l
print sin $pi / 6;                #sin30�� ���ʁF0.4999...
print "\n";
print cos $pi / 3;                #cos60�� ���ʁF0.5000...
print "\n";
print tan($pi / 4);               #tan45�� ���ʁF0.9999...
sub tan { sin($_[0]) / cos($_[0])}#�^���W�F���g�i���ځj�T�u���[�`��
print "</PRE></BODY></HTML>";
