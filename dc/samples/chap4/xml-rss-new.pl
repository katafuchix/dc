#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::RSS;                              #XML::RSSモジュール読み込み
$rss09 = new XML::RSS (version => '0.9');  #RSS0.9指定でインスタンス生成
$rss091 = new XML::RSS (version => '0.91');#RSS0.91指定でインスタンス生成
$rss10 = new XML::RSS (version => '1.0');  #RSS1.0指定でインスタンス生成
$rss10->parsefile("sample-rss.rdf");       #RSS1.0ファイル読み込み
print $rss10->channel(title);    #チャンネルのタイトル出力。結果：Test Blog!
print "</PRE></BODY></HTML>";
