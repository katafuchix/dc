#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use DBI;            # DBIモジュールの呼び出し
# MySQLのsampleデータベースへ接続
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
# test_tableというテーブルを作成するSQLステートメント
$create_statement = "CREATE TABLE `test_table` (
                                               `id` int,            # ID
                                               `name` varchar(255), # 名前
                                               `tel` varchar(12)    # 電話番号
                                               )";
# 追加するデータの値
# 　id：1  名前：John  電話番号：99-9999-9999
# test_tableにデータを追加するSQLステートメント
$insert_statement = "INSERT INTO `test_table`
                     VALUES (1, 'John', '99-9999-9999')";
# test_tableから指定したidを持つデータ件数を取得するSQLステートメント
$select_statement = "SELECT COUNT(*) FROM test_table WHERE id = ? ";
# create_statemenをdoメソッドで実行
$rc = $dbh->do($create_statement) || die $dbh->errstr;
# insert_statementをprepareメソッドとexecuteメソッドを組み合わせた関数で実行
prepare_execute_do($dbh,$insert_statement);
# idに1を持つデータ件数を取得
$sth = $dbh->prepare($select_statement) or print $dbh->errstr; #SQLを準備
# プレースホルダに1を割り当ててSQLを実行
$rv = $sth->execute(1) or print $sth->errstr;
while( my $ref = $sth->fetch ){              # 検索結果を取得
  my ($count) = @$ref;
  print "idに1を持つデータ件数：".$count;
  # 結果：idに11を持つデータ件数：1
}
$dbh->disconnect(); #データベースと切断
print "</body></html>";              #HTML出力

#prepareメソッドとexecuteメソッドを組み合わせたdoメソッドと同じ動きの関数
sub prepare_execute_do { 
    my($dbh, $statement, $attr, @bind_values) = @_;
    my $sth = $dbh->prepare($statement, $attr) or return undef;
    $sth->execute(@bind_values) or return undef;
    my $rows = $sth->rows;
    ($rows == 0) ? "0E0" : $rows; # always return true if no error
}
