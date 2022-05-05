#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use DBI;            # DBIモジュールの呼び出し
# MySQLのsampleデータベースへ接続
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
# test_tableに格納されているIDが3以下のデータを取得するSQL
$select_sql = "SELECT * FROM test_table WHERE id <= 3 ";
$sth = $dbh->prepare($select_sql) or print $dbh->errstr; #SQLを準備
$rv = $sth->execute() or print $sth->errstr; # SQLを実行
$result = $sth->dump_results(50,"<br>","|"); # 検索結果を出力する
print "<br>検索件数：".$result;              # 検索件数を表示
# 結果
# '1'|'John'|'99-9999-9999'
# '2'|'Perl'|'99-9999-9991'
# '3'|'Mike'|'99-9999-9992' 3 rows 
#  検索件数：3
$dbh = DBI->disconnect();

print "</body></html>";              #HTML出力
