#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use LWP::UserAgent;
use HTTP::Request;          #HTTP::Request���W���[���ǂݍ���
$ua = new LWP::UserAgent();
$req = new HTTP::Request("GET","http://httpserver/");
 #HTTP::Request�C���X�^���X�����BHTTP GET�v���g�R��
$response = $ua->request($req);
 #HTTP::Request���g�p���ă��N�G�X�g����
print $response->code();
 #HTTP::Response�̃��X�|���X�R�[�h�o�́B���ʁF200
print "</PRE></BODY></HTML>";
