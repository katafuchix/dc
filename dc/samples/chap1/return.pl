#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
sub sub_a{           #引数を取らないサブルーチン
  if($val > 5){      #グローバル変数$valが5未満なら
    return $val;     #処理を終了して$valを返す
  }else{             #そうでなければ
    return $val * 2; #$valの2倍を返す
  }
}
$val = 10;
print sub_a;         #sub_aは上で宣言済なので接頭辞は不要
#sub_aの戻り値は10。結果：10
do &sub_a;           #do関数を使って呼び出し
print "</PRE></BODY></HTML>";
