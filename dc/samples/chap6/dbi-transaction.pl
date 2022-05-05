#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use DBI;            # DBIモジュールの呼び出し
# MySQLのsampleデータベースへ接続
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
$dbh->{AutoCommit} = 0;  # 可能であれば、トランザクションを有効にします
$dbh->{RaiseError} = 1;  # エラー発生時に例外として扱いeval関数に渡す
#test_tableに格納されているデータ件数を取得
$select_sql = "SELECT COUNT(*) FROM test_table ";
$ref = $dbh->selectrow_array($select_sql); # データ追加前のデータ件数を表示
print "sample_tableに格納されている列数：".$ref."<br>"; #結果：3
eval {
    # test_tableにデータを追加するSQLステートメント
    $insert_statement = "INSERT INTO `test_table`
                            VALUES (4, 'Jim', '99-9999-9994')";
    $rc = $dbh->do($insert_statement) || die $dbh->errstr; #SQLを実行する
    $dbh->commit;   # データの追加をコミットする
    print "コミットしました<br>";
};
if ($@) {
    $dbh->rollback; # 処理を取り消します
    print "ロールバックしました<br>";
}
$ref = $dbh->selectrow_array($select_sql); # データ追加後のデータ件数を表示
print "sample_tableに格納されている列数：".$ref."<br>"; #結果：4
$dbh = DBI->disconnect();

print "</body></html>";              #HTML出力
