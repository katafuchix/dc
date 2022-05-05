#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use SDBM_File;     #DBMファイルを開くためのSDBM_Fileモジュール定義を読み込む
tie(%hash, 'SDBM_File', 'test', 1, 0);#"test"DBMファイルを開いてバインドする
while (($key,$val) = each %hash) {    #連想配列から要素取得
  print $key.'='.$val;                #値出力。結果：test=10
}
if(tied %hash){                       #バインドされていれば
  untie %hash;                        #バインド解除
}
print "</PRE></BODY></HTML>";
