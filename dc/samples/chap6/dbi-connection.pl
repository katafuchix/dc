#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use DBI;            # DBIモジュールの呼び出し
# MySQLのsampleデータベースへ接続
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
# データベース・ハンドルから selectrorw_array を呼び出す
$ref = $dbh->selectrow_array( "SELECT COUNT(*) FROM sample_table ");
print "sample_tableに格納されている列数：".$ref;
# 結果：sample_tableに格納されている列数：1
$dbh->disconnect(); #データベースと切断

print "</body></html>";              #HTML出力
exit;