#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
($usertime,$systemtime,$childusertime,$childsystemtime) = times; #���Ԏ擾
print $usertime;   #���[�U���ԁB���ʁF0.031
print "\n";
print $systemtime; #�V�X�e�����ԁB���ʁF0.015
print "\n";
print $cusertime;  #�q�v���Z�X���[�U���ԁB���ʁF�i�Ȃ��j
print "\n";
print $csystemtime;#�q�v���Z�X�V�X�e�����ԁB���ʁF�i�Ȃ��j
print "</PRE></BODY></HTML>";
