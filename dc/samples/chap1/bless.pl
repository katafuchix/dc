#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use SampleClass; #SampleClassモジュール呼び出し。SampleClass.pmインポート
$sample = new SampleClass; #インスタンスを生成し、リファレンスをスカラ変数に格納
print $sample->getString;  #リファレンスのメソッド呼び出し
#結果：SampleClass::getString!
print "</PRE></BODY></HTML>";
