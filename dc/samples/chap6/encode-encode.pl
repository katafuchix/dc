print "Content-type: text/html;charset=utf-8\n\n"; #HTTPヘッダ出力
#このスクリプトはshift-jisで保存されている
use Encode;
$string = "こんにちは";
$decoded_str = decode("shiftjis", $string);  #Shift-JISからデコード
$encoded_str = encode("utf-8", $decoded_str);#utf-8にエンコード
print $encoded_str."<br>";                   #エンコードした文字列を表示
# 結果：こんにちは
$encoded_utf8 = encode_utf8($decoded_str);   #utf-8にエンコード
print $encoded_utf8; #UTF-8にエンコードした文字列を表示
# 結果：こんにちは

print "</body></html>";              #HTML出力
