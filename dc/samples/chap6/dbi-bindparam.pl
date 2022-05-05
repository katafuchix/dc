#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use DBI;            # DBIモジュールの呼び出し
# MySQLのsampleデータベースへ接続
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
@ids = (1,2); #バインド用のidをセット
# test_tableに格納されているデータをIDを指定して取得するSQL
# ID部分にプレースホルダを割り当てる
$select_sql = "SELECT * FROM test_table WHERE id = ? ";
$sth = $dbh->prepare($select_sql) or print $dbh->errstr; #SQLを準備
foreach(@ids){
  $sth->bind_param(1,$_);  # SELECT文のプレースホルダに値を代入する
  $rv = $sth->execute() or print $sth->errstr; # SQLを実行
  while( my $ref = $sth->fetch ){              # 検索結果を取得
    my ($id, $name,$tel) = @$ref;
    print $id."|".$name."|".$tel."<br>";       # 検索結果を表示
  }                                            # 結果：1|John|99-9999-9999
}                                              #       2|Perl|99-9999-9991
$dbh = DBI->disconnect();

print "</body></html>";              #HTML出力
