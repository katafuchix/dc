#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::RSS;                           #XML::RSSモジュール読み込み
$rss = new XML::RSS (version => "1.0"); #RSS1.0指定でインスタンス生成
$rss->channel(title => "Test Blog!",    #チャンネル情報設定
              link => "http://virualdomain/blog/001/",
              description => "Test blog site"
              );
$rss->add_item(title => "2/20日記",    #アイテム追加
              link => "http://virualdomain/blog/001/20060220",
              description => "今日はどんよりとした曇り空..."
              );
$rss->add_item(title => "3/18日記",    #アイテム追加
              link => "http://virualdomain/blog/001/20060315",
              description => "宮古島は快晴。ダイビング日和..."
              );
print $rss->as_string();                #結果出力
print "</PRE></BODY></HTML>";
