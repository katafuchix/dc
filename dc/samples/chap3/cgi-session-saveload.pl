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

$session->save_param($q,["email"]);#POST�p�����[�^���Z�b�V�����ɏ�������
#�ȉ�2�s�Ɠ�������������
 #$email = $q->param("email");
 #$session->param("email",$email);
$session->load_param($q,["email","message"]);
#�Z�b�V�������畡���̃p�����[�^��POST�p�����[�^�ɓǂݏo��
print $q->param("message"); #�Z�b�V��������ǂݏo����POST�p�����[�^�o��
 #���ʁF����ɂ��̓Z�b�V�����icgi-session-new.pl�ŃZ�b�V�����ɐݒ肵���l�j
print <<EOD;
    <br/>
  </body>
</html>
EOD
$session->flush(); #�Z�b�V���������o��
