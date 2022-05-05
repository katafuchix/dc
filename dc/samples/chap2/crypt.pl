#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$password = "himitsu";              #パスワード
$key = "su";                        #暗号化キー
$cryptkey = crypt $password,$key;
print $cryptkey;               #暗号化された文字列。結果例：su.9vZqPON4OQ
$input = "himitsu";                 #正しいパスワードを
if($cryptkey eq crypt $input,$key){ #文字列を暗号化して照合
  print "認証成功";
}else{
  print "認証失敗";
}
print "</PRE></BODY></HTML>";
