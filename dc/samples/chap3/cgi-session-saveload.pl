#!/usr/bin/perl
use CGI;
use CGI::Session;
$q = new CGI();
$session = CGI::Session->new(undef,$q,{Directory=>'/tmp'});
#CGIオブジェクトを指定してセッションを生成
print $session->header(-charset => "shift-jis"); #HTTPヘッダ出力
print <<EOD;
<html>
  <body>
EOD

$session->save_param($q,["email"]);#POSTパラメータをセッションに書き込み
#以下2行と同じ働きをする
 #$email = $q->param("email");
 #$session->param("email",$email);
$session->load_param($q,["email","message"]);
#セッションから複数のパラメータをPOSTパラメータに読み出し
print $q->param("message"); #セッションから読み出したPOSTパラメータ出力
 #結果：こんにちはセッション（cgi-session-new.plでセッションに設定した値）
print <<EOD;
    <br/>
  </body>
</html>
EOD
$session->flush(); #セッション書き出し
