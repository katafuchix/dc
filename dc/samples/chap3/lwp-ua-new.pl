#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use LWP::UserAgent;
$ua = new LWP::UserAgent();
$ua->agent("MyWebClient"); #ユーザエージェント設定
$ua->timeout(20);          #タイムアウト秒数を20秒に設定
$ua->max_size(1000);       #最大サイズを1000バイトに設定
print $ua->get("http://www.yahoo.co.jp")->as_string(); #GETリクエスト結果表示
print "</PRE></BODY></HTML>";
