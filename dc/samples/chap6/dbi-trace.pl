#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use DBI;            # DBIモジュールの呼び出し
#トレースレベル1でトレース情報をDBtrace.logに出力する
DBI->trace(1, 'DBtrace.log');
# DBIモジュールを使っていくつかの処理を実行する
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
#$dbh->trace(1);
$select_sql="SELECT * FROM test_table";
$sth = $dbh->prepare($select_sql) or  die $dbh->errstr; #SQLを準備
$sth->execute()  or  die $sth->errstr;                  #SQLを実行
#$sth->trace(1);
$dbh->disconnect();
# DBIモジュールを使った処理終了
open( TEXTFILE, "DBtrace.log" );       #トレース情報を出力する
@lines = <TEXTFILE>;
foreach ( @lines ) {
  print $_."<br>";
}
close( TEXTFILE );
print "</body></html>";              #HTML出力
