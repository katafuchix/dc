print "Content-type: text/html;charset=euc-jp\n\n"; #HTTPヘッダ出力
#このスクリプトはShift-JISで保存されている
use Encode;
$string = "こんにちは";
# Shift-JISからEUC-JPに文字コードを変換
Encode::from_to ( $string , 'shiftjis' , 'euc-jp' );
print $string; # 文字コードを変換した文字列を表示
               # 結果："こんにちわ"
$string = "こんにちは";
#decodeメソッドとencodeメソッドを利用して文字コードを変換
$decoded_str = decode("shiftjis", $string);          #Shift-JISからデコード
$encoded_str = encode("euc-jp", $decoded_str);       #EUC-JPにエンコード
print $encoded_str; # 文字コードを変換した文字列を表示
                    # 結果　：こんにちは
print "</body></html>";              #HTML出力
