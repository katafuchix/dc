#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use MIME::QuotedPrint;             #MIME::QuotedPrintモジュール読み込み
$enc = encode_qp("Hello\aWorld!"); #文字列をQuotedPrintエンコード
print $enc;#エンコード結果出力。\aは"=07"にエンコード。結果：Hello=07World!=
$dec = decode_qp($enc);            #文字列をQuotedPrintデコード
print "\n";
print $dec;                        #デコード結果出力。結果：Hello World!
no MIME::QuotedPrint;                      #MIME::QuotedPrintモジュール取り消し
use MIME::QuotedPrint ();                  #メソッドをインポートしない場合
$enc = MIME::QuotedPrint::encode_qp("Hello World!"); #パッケージ名付きで呼び出し
$dec = MIME::QuotedPrint::decode_qp($enc);           #パッケージ名付きで呼び出し
print "\n";
print $dec;          #デコード結果出力。結果：Hello World!
print "</PRE></BODY></HTML>";
