#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use LWP::UserAgent;
use HTTP::Request;
$ua = new LWP::UserAgent();
$req = new HTTP::Request("GET","ftp://localhost/sample.txt"); #HTTP::Request�쐬
 #FTP���N�G�X�g���g�p
$res = $ua->request($req);#HTTP::Request���g�p���ă��\�[�X�擾
print $res->content();    #FTP���N�G�X�g�Ŏ擾�����t�@�C���̓��e
print "</PRE></BODY></HTML>";
