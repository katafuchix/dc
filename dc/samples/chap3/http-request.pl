#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use LWP::UserAgent;
use HTTP::Request;
$ua = new LWP::UserAgent();
$req = new HTTP::Request("GET","ftp://localhost/sample.txt"); #HTTP::Request作成
 #FTPリクエストを使用
$res = $ua->request($req);#HTTP::Requestを使用してリソース取得
print $res->content();    #FTPリクエストで取得したファイルの内容
print "</PRE></BODY></HTML>";
