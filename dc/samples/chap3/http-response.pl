#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use LWP::UserAgent;
use HTTP::Request;
$ua = new LWP::UserAgent();
$req = new HTTP::Request("GET","http://www.yahoo.co.jp/"); #HTTP::Request作成
$res = $ua->request($req);#HTTP::Requestを使用してリソース取得
print $res->code();       #ステータスコード出力。結果：200
print "\n";
print $res->message();    #レスポンスメッセージ出力。結果：OK
print "\n";
$req = new HTTP::Request("GET","ftp://localhost/sample.txt"); #HTTP::Request作成
$res = $ua->request($req);#HTTP::Requestを使用してFTPファイル取得
print $res->content();    #FTPリクエストで取得したファイルの内容にアクセス
print "</PRE></BODY></HTML>";
