#!/usr/bin/perl
use CGI;                                   #CGI���W���[���Ăяo��
$query = new CGI();
$cookie = $query->cookie(-name=>'count',   #�N�b�L�[�쐬
                 -value=>0,                #�l��0
                 -path => "/cgiperl/",     #/cgiperl/�p�X�ŗL��
                 -expires => "+5h"         #5���ԗL��
                         );                #'count'�N�b�L�[���쐬
print $query->header(-cookie=>$cookie);    #�N�b�L�[���o�͂���
print $query->start_html();                #HTML�J�n
print $value;                              #�N�b�L�[�̒l���o�́B���ʁF1,2,3,4,5...
print $query->end_html();                  #HTML�I��
