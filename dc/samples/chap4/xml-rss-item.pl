#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::RSS;                           #XML::RSSモジュール読み込み
$rss = new XML::RSS (version => "1.0"); #RSS1.0指定でインスタンス生成
$rss->channel(title => "Test Blog!",link => "http://virualdomain/blog/001/");
$rss->add_item(title => "2/20日記",    #アイテム追加
              link => "http://virualdomain/blog/001/20060220",
              description => "今日はどんよりとした曇り空...");
print $rss->as_string();
print "</PRE></BODY></HTML>";
