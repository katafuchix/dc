#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::RSS;                           #XML::RSSモジュール読み込み
$rss = new XML::RSS (version => "1.0"); #RSS1.0指定でインスタンス生成
$rss->channel(title => "Test Blog!",    #チャンネル情報設定
              link => "http://virualdomain/blog/001/",
              description => "Test blog site",
              dc => {                   #Dublin Coreを使用してメタデータ記述
                date => "2006-02-20",   #更新日
                creator => "Doi"        #著者
                });
print $rss->channel(title);    #チャンネルのタイトル出力。結果：Test Blog!
print "</PRE></BODY></HTML>";
