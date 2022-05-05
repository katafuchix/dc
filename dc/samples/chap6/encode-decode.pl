print "Content-type: text/html;charset=shift-jis\n\n"; #HTTPヘッダ出力
#このスクリプトはutf-8で保存されている
use Encode;
$string = "こんにちは";
$decoded_str = decode("utf-8", $string);               #utf-8からデコード
$encoded_str = encode("shiftjis", $decoded_str);       #Shift-JISにエンコード
print $encoded_str; # エンコードした文字列を表示
                    # 結果　：こんにちは
$decoded_utf8 = decode_utf8($string);                  #utf-8からデコード
$encoded_utf8 = encode("shiftjis", $decoded_utf8);     #Shift-JISにエンコード
print $encoded_utf8;# エンコードした文字列を表示
                    # 結果　：こんにちは
print "</body></html>";              #HTML出力
