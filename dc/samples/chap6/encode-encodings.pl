print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use Encode;
@list = Encode->encodings();
@list_jp = Encode->encodings("Encode::JP");
print @list;     # Encodeで定義されている文字コード名の一覧を表示
                 # 結果　：　""
print @list_jp;  # Encode::JPで定義されている文字コード名の一覧を表示
                 # 結果　：　""
                 
print "</body></html>";              #HTML出力