#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use LWP::UserAgent;
use HTTP::Request;
$ua = new LWP::UserAgent();
$req = new HTTP::Request("GET","http://www.yahoo.co.jp/"); #HTTP::Request�쐬
$res = $ua->request($req);#HTTP::Request���g�p���ă��\�[�X�擾
print $res->code();       #�X�e�[�^�X�R�[�h�o�́B���ʁF200
print "\n";
print $res->message();    #���X�|���X���b�Z�[�W�o�́B���ʁFOK
print "\n";
$req = new HTTP::Request("GET","ftp://localhost/sample.txt"); #HTTP::Request�쐬
$res = $ua->request($req);#HTTP::Request���g�p����FTP�t�@�C���擾
print $res->content();    #FTP���N�G�X�g�Ŏ擾�����t�@�C���̓��e�ɃA�N�Z�X
print "</PRE></BODY></HTML>";
