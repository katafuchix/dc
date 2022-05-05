#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use LWP::UserAgent;
use HTTP::Request;          #HTTP::Requestモジュール読み込み
$ua = new LWP::UserAgent();
$req = new HTTP::Request("GET","http://httpserver/");
 #HTTP::Requestインスタンス生成。HTTP GETプロトコル
$response = $ua->request($req);
 #HTTP::Requestを使用してリクエスト処理
print $response->code();
 #HTTP::Responseのレスポンスコード出力。結果：200
print "</PRE></BODY></HTML>";
