#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use DBI;            # DBIモジュールの呼び出し
# MySQLのsampleデータベースへ接続 接続失敗時にはエラー出力
$db_source = "dbi:mysql:sample";
$dbh = DBI->connect($db_source, "root", "admin") || print $DBI::errstr."<br>" ;
# エラー出力させるためのtest_tableの実際には存在しないaaフィールドから
# データ取得するSQLステートメント
$select_sql = "SELECT aa FROM test_table ";
# SQLを準備 失敗時にはエラー出力
$sth = $dbh->prepare($select_sql) or print $dbh->errstr."<br>";
# SQLを実行 失敗時にはエラー出力
if (!$sth->execute()){
    print "エラー： ".$sth->err." ".$sth->errstr."<br>";
# 結果：エラー： 1054 Unknown column 'aa' in 'field list'
}
$dbh->disconnect(); #データベースと切断

print "</body></html>";              #HTML出力
