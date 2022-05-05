#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

# 下記のような構成のテーブル（test_table）からデータを取得
#+------+-------+--------------+
#| id   | name  | tel          |
#+------+-------+--------------+
#|    1 | John  | 99-9999-9999 |
#|    2 | Perl  | 99-9999-9991 |
#|    3 | Mike  | 99-9999-9992 |
#+------+-------+--------------+
use DBI;            # DBIモジュールの呼び出し
# MySQLのsampleデータベースへ接続
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
# test_tableから全てのデータを検索するSELECT文
$select_sql="SELECT * FROM test_table";
$sth = $dbh->prepare($select_sql) or  die $dbh->errstr; #SQLを準備
$sth->execute()  or  die $sth->errstr;                  #SQLを実行
$row_count = $sth->rows();                              #検索件数を取得
print "検索件数：".$row_count."<br>";                   #結果例 検索件数：8
#fetchメソッドでデータを取得する
#昇順にデータ行のリファレンスを取り出す
while( my $ref = $sth->fetch ){        
  my ($id, $name,$tel) = @$ref;        #リファレンスをスカラー変数に格納
  print $id."|".$name."|".$tel."<br>"; #検索結果を表示
}
# 結果：
# 1|John|99-9999-9999
# 2|Perl|99-9999-9991
# 3|Mike|99-9999-9992
print "<hr>";
# test_tableから名前と電話番号データを検索するSELECT文
$select_sql="SELECT name,tel FROM test_table";
$sth = $dbh->prepare($select_sql) or  die $dbh->errstr; #SQLを準備
$sth->execute()  or  die $sth->errstr;                  #SQLを実行
#fetchrow_arrayメソッドでデータを取得する
#昇順にデータ行の配列を取り出す
while( my @arr = $sth->fetchrow_array ){ 
  my ($name,$tel) = @arr;         #配列をスカラー変数に格納
  print $name."|".$tel."<br>"; #検索結果を表示
}
# 結果
# John|99-9999-9999|
# Perl|99-9999-9991|
# Mike|99-9999-9992|
print "<hr>";
# test_tableからidと名前のデータを検索するSELECT文
$select_sql="SELECT id,name FROM test_table";
$sth = $dbh->prepare($select_sql) or  die $dbh->errstr; #SQLを準備
$sth->execute()  or  die $sth->errstr;                  #SQLを実行
#fetchrow_hashrefメソッドでデータを取得する
#昇順にデータ行のハッシュを取り出す
while( my $href = $sth->fetchrow_hashref() ){
  print $href->{id}."|".$href->{name}."<br>"; #検索結果を表示
}
# 結果
# 1|John|
# 2|Perl|
# 3|Mike|
print "<hr>";
# test_tableから全てのデータを検索するSELECT文
$select_sql="SELECT * FROM test_table";
$sth = $dbh->prepare($select_sql) or  die $dbh->errstr; #SQLを準備
$sth->execute()  or  die $sth->errstr;                  #SQLを実行
$all_ref = $sth->fetchall_arrayref([1,2]);       #2番目と3番目のデータのみ選択
$num = @$all_ref;                                       #データ件数を取得
for ($i = 0; $i < $num; $i++) {                         #検索結果を表示
  print $all_ref->[$i][0]."|". $all_ref->[$i][1]."<br>";
}
# 結果
# John|99-9999-9999|
# Perl|99-9999-9991|
# Mike|99-9999-9992|
$dbh->disconnect(); #データベースと切断

print "</body></html>";              #HTML出力
