#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@info = getservbyname "http","tcp"; #http�̃T�[�r�X���擾
print $info[0];                     #�T�[�r�X���o�́B���ʁFhttp
print "\n";
print $info[1];                     #�G�C���A�X�o�́B���ʁFwww
print "\n";
print $info[2];                     #�|�[�g�ԍ��o�́B���ʁF80
print "\n";
@info = getservbyport 21,"tcp";     #�|�[�g�ԍ�21�̃T�[�r�X���擾
print $info[0];                     #�T�[�r�X���o�́B���ʁFftp
print "\n";
print $info[1];                     #�G�C���A�X�o�́B���ʁFfsp
print "\n";
print $info[2];                     #�|�[�g�ԍ��o�́B���ʁF21
print "</PRE></BODY></HTML>";
