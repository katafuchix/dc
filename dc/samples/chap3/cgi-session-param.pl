#!/usr/bin/perl
use CGI;
use CGI::Session;
$q = new CGI();
$session = CGI::Session->new(undef,$q,{Directory=>'/tmp'});
#CGI�I�u�W�F�N�g���w�肵�ăZ�b�V�����𐶐�
print $session->header(-charset => "shift-jis"); #HTTP�w�b�_�o��
print <<EOD;
<html>
  <body>
EOD
$email = $q->param("email");    #POST�p�����[�^�擾
$session->param("email",$email);#�Z�b�V�����Ƀp�����[�^���
print $session->param("email"); #���Őݒ肵���p�����[�^�o��
#���ʁFdoi@virtualdomain�icgi-session-new.pl�̃e�L�X�g�{�b�N�X�ɓ��͂������e�j
$params = $session->param_hashref();        #�S�p�����[�^�擾
print "<br/>".$params->{"message"}; #�A�z�z�񂩂�p�����[�^�o��
#���ʁF����ɂ��̓Z�b�V�����icgi-session-new.pl�ŃZ�b�V�����ɐݒ肵���l�j
$session->clear();               #�Z�b�V�����p�����[�^�̃N���A
print "<br/>".$params->{"message"}; #�p�����[�^�̓N���A�ρB���ʁF�i�Ȃ��j
print <<EOD;
    <br/>
    <a href="cgi-session-saveload.pl">Next</a>
  </body>
</html>
EOD
$session->flush(); #�Z�b�V���������o��
