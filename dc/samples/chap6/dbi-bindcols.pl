#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力
# 下記のような構成のテーブル（test_table）からデータを取得
#+------+-------+--------------+
#| id | name | tel |
#+----+------+--------------+
#| 1  | John | 99-9999-9999 |
#| 2  | Perl | 99-9999-9991 |
#| 3  | Mike | 99-9999-9992 |
#+----+------+--------------+
use DBI;            # DBIモジュールの呼び出し
# MySQLのsampleデータベースへ接続
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
# test_tableからid=2のデータを検索するSELECT文
$select_sql1 = "SELECT * FROM test_table WHERE id = 2 ";
$sth = $dbh->prepare($select_sql1) or  die $dbh->errstr; #SQLを準備
$sth->execute()  or  die $sth->errstr;                  #SQLを実行
# bind_colの使用方法
$sth->bind_col(1, \$id);                   # フィールド1をidに格納
$sth->bind_col(2, \$name);                 # フィールド2をnameに格納
$sth->bind_col(3, \$tel);                  # フィールド3をtelに格納
while ( $sth->fetch ){
  print $id."|".$name."|".$tel."<br>"; #検索結果を表示
}                                      # 結果：2|Perl|99-9999-9991
# データを追加する
$insert_statement = "INSERT INTO `test_table`
                      VALUES (5, 'Bob', '99-9999-9995')";
$sth = $dbh->prepare($insert_statement) or  die $dbh->errstr; #SQLを準備
$sth->execute()  or  die $sth->errstr;                        #SQLを実行
$row_count = $sth->rows();              #影響があった行数を取得
print "追加された行：".$row_count;      #結果例 追加された行：1
# test_tableから追加したid=5のデータを検索するSELECT文
$select_sql2 = "SELECT * FROM test_table WHERE id = 5 ";
$sth = $dbh->prepare($select_sql2) or  die $dbh->errstr;#SQLを準備
$sth->execute()  or  die $sth->errstr;                  #SQLを実行
#フィールド1をid2にフィールド2をname2にフィールド3をtel2に格納
$sth->bind_columns(\($id2, $name2,$tel2));
while ($sth->fetch) {
  print $id2."|".$name2."|".$tel2."<br>"; #検索結果を表示
}                                         # 結果：5|Bob|99-9999-9995
$dbh->disconnect(); #データベースと切断

print "</body></html>";              #HTML出力
exit;