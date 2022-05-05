#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use DBI;            # DBIモジュールの呼び出し
# MySQLのsampleデータベースへ接続
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
$select_sql1 = "SELECT * FROM test_table WHERE id = %s ";
$select_sql2 = "SELECT * FROM test_table WHERE name = %s ";
@number_list = (1,"Don't",'te"st',2);
@ret_bool = DBI::looks_like_number(@number_list);  #数値チェック
$counter = 0;
foreach(@ret_bool){
  if($_){#数値であればidフィールドに対して条件をつける
    $tmp_select = sprintf($select_sql1,$dbh->quote(@number_list[$counter]));
    print $tmp_select."<br>";
  }
  else{  #それ以外の場合はnameフィールドに対して条件をつける
    $tmp_select = sprintf($select_sql2,$dbh->quote(@number_list[$counter]));
    print $tmp_select."<br>";
  }
  $sth = $dbh->prepare($tmp_select) or print $dbh->errstr; #SQLを準備
  $rv = $sth->execute() or print $sth->errstr; # SQLを実行
  while( my $ref = $sth->fetch ){            # 検索結果を取得
    $ret_str_list = DBI::neat_list($ref,);
    print "出力結果：".$ret_str_list."<br>"; # 検索結果を表示
  }
  $counter ++;
}
$dbh = DBI->disconnect();
#結果
#SELECT * FROM test_table WHERE id = '1' 
#出力結果：'1', 'John', '99-9999-9999'
#SELECT * FROM test_table WHERE name = 'Don\'t' 
#SELECT * FROM test_table WHERE name = 'te\"st' 
#SELECT * FROM test_table WHERE id = '2' 
#出力結果：'2', 'Perl', '99-9999-9991'

print "</body></html>";              #HTML出力

