#!/usr/bin/perl
use CGI;
my $query = new CGI();
print $query->header();                          #HTTPヘッダを出力
print $query->start_html();                      #HTML開始
print "FirstName : ".$query->param("FirstName"); #結果 : tsuyoshi
print $query->br();                              #<br/>タグ出力
print "LastName : ".$query->param("LastName");   #結果 : doi
print $query->end_html();                        #HTML終了
