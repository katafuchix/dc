#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use LWP::UserAgent;
$ua = new LWP::UserAgent();
$ua->agent("MyWebClient"); #���[�U�G�[�W�F���g�ݒ�
$ua->timeout(20);          #�^�C���A�E�g�b����20�b�ɐݒ�
$ua->max_size(1000);       #�ő�T�C�Y��1000�o�C�g�ɐݒ�
print $ua->get("http://www.yahoo.co.jp")->as_string(); #GET���N�G�X�g���ʕ\��
print "</PRE></BODY></HTML>";
