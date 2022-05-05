#!/usr/bin/perl
use CGI;
$q = new CGI();
print $q->header(-charset => "shift-jis");            #HTTPヘッダ出力
print $q->start_html(-title => "sample title",);      #HTMLヘッダ出力
print $q->p(
  {-valign => 'top'},        #valign属性指定
  $q->h1("見出し1"),         #入れ子でh1タグ出力
  "普通の文字列",            #タグの内容
  $q->br(),                  #入れ子でbrタグ出力
  $q->Link("リンク文字列")   #タグ名と異なるメソッド
  );
print $q->end_html();        #HTML終了
