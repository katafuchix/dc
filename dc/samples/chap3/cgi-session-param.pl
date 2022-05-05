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
$email = $q->param("email");    #POSTパラメータ取得
$session->param("email",$email);#セッションにパラメータ代入
print $session->param("email"); #↑で設定したパラメータ出力
#結果：doi@virtualdomain（cgi-session-new.plのテキストボックスに入力した内容）
$params = $session->param_hashref();        #全パラメータ取得
print "<br/>".$params->{"message"}; #連想配列からパラメータ出力
#結果：こんにちはセッション（cgi-session-new.plでセッションに設定した値）
$session->clear();               #セッションパラメータのクリア
print "<br/>".$params->{"message"}; #パラメータはクリア済。結果：（なし）
print <<EOD;
    <br/>
    <a href="cgi-session-saveload.pl">Next</a>
  </body>
</html>
EOD
$session->flush(); #セッション書き出し
