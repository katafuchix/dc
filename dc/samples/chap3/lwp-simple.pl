#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use LWP::Simple;
print head("http://www.yahoo.co.jp/"); #HEAD���N�G�X�g�Ńw�b�_�����擾�B
#���ʁFtext/html;charset=euc-jp
getprint("http://www.yahoo.co.jp/"); #GET���N�G�X�g���ʂ�W���o��
#���ʁF<html><head>...
print "</PRE></BODY></HTML>";
