print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use Encode;
use Encode::Guess;
$data = "hoge";
$enc = guess_encoding( $data );   # $dataのエンコード形式を取得
print $enc->name;                 # エンコード形式を表示 結果： ascii
print "</body></html>";              #HTML出力
