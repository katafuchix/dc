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
# test_tableから名前と電話番号を検索するSELECT文
$select_sql="SELECT name,tel FROM test_table";
#selectrow_arrayメソッドで検索し、検索結果の先頭データ行の配列を取り出す
@arr = $dbh->selectrow_array($select_sql);
($name,$tel) = @arr;             #配列をスカラー変数に格納
print $name."|".$tel."<br>"; #検索結果を表示
# 結果：John|99-9999-9999
print "<hr>";
# selectall_arrayrefで全ての検索結果の配列へのリファレンスを取得
$all_ref = $dbh->selectall_arrayref($select_sql);
$num = @$all_ref;                                       #データ件数を取得
for ($i = 0; $i < $num; $i++) {                         #検索結果を表示
  print $all_ref->[$i][0]."|". $all_ref->[$i][1]."<br>";
}
# 結果
# John|99-9999-9999
# Perl|99-9999-9991
# Mike|99-9999-9992
print "<hr>";
#selectcol_arrayrefメソッドでデータの最初のフィールド
#この場合はnameフィールドのデータを取得する
$arr_ref = $dbh->selectcol_arrayref($select_sql);
$num = @$arr_ref;                                       #データ件数を取得
for ($i = 0; $i < $num; $i++) {                         #検索結果を表示
  print $arr_ref->[$i].",";
}
# 結果（名前だけ取得している）： John,Perl,Mike,
$dbh->disconnect(); #データベースと切断

print "</body></html>";              #HTML出力
