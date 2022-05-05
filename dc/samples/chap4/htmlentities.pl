#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::Entities;             #HTML::Entitiesモジュール読み込み
$enc = encode_entities("<Hello>あいう"); #文字列をHTMLエンティティにエンコード
print $enc;#エンコード結果出力。<>と日本語はエンコード
#結果：&lt;Hello&gt;&#130;&nbsp;&#130;&cent;&#130;&curren;
$dec = decode_entities($enc);            #文字列のHTMLエンティティをデコード
print "\n";
print $dec;                     #デコード結果出力。結果：<Hello>あいう
print "</PRE></BODY></HTML>";
