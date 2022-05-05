#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use MIME::Base64;                     #MIME::Base64モジュール読み込み
$enc = encode_base64("Hello World!"); #文字列をBase64エンコード
print $enc;          #エンコード結果出力。結果：SGVsbG8gV29ybGQh
$dec = decode_base64($enc);           #文字列をBase64デコード
print $dec;          #デコード結果出力。結果：Hello World!
print "\n";
no MIME::Base64;                      #MIME::Base64モジュール取り消し
use MIME::Base64 ();                  #メソッドをインポートしない場合
$enc = MIME::Base64::encode_base64("Hello World!"); #パッケージ名付きで呼び出し
$dec = MIME::Base64::decode_base64($enc);           #パッケージ名付きで呼び出し
print $dec;          #デコード結果出力。結果：Hello World!
print "</PRE></BODY></HTML>";
