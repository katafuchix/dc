#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use DBI;            # DBIモジュールの呼び出し
@drivers = DBI->available_drivers; # 利用可能なデータベースドライバの取得
foreach(@drivers){                 # 取得したデータベースドライバ名を表示
  print $_."<br>";
}
#DBMで利用可能なデータソースリストを取得
@sources = DBI->data_sources(DBM); 
foreach(@sources){                 # 取得したデータソース名を表示
  print $_."<br>";
}

print "</body></html>";              #HTML出力

x