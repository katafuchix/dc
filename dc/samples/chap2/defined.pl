#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sub a{
}
print not defined $b; #�ϐ�$b�͖���`�B���ʁF1
print "\n";
print defined &a;     #�T�u���[�`��&a�͒�`����Ă���B���ʁF1
print "</PRE></BODY></HTML>";
