#!/usr/bin/perl
use CGI::Session;
$session = new CGI::Session(undef,undef,{Directory=>'/tmp'});#�V�K�Z�b�V�����쐬
$session->expire('+1h');  #�L��������1����
$session->param("message","����ɂ��̓Z�b�V����"); #�Z�b�V�����p�����[�^�ɒl����
print $session->header(-charset => "shift-jis"); #HTTP�w�b�_�o��
print <<EOD;
<html>
  <body>
EOD
print <<EOD;
    <form action="cgi-session-param.pl" method="POST">
      <input type="text" name="email"/>
      <input type="submit" value="Send"/>
    </form>
  </body>
</html>
EOD
$session->flush(); #�Z�b�V���������o��
