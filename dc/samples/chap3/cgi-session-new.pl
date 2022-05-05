#!/usr/bin/perl
use CGI::Session;
$session = new CGI::Session(undef,undef,{Directory=>'/tmp'});#新規セッション作成
$session->expire('+1h');  #有効期限は1時間
$session->param("message","こんにちはセッション"); #セッションパラメータに値を代入
print $session->header(-charset => "shift-jis"); #HTTPヘッダ出力
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
$session->flush(); #セッション書き出し
