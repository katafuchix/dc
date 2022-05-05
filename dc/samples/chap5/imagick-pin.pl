print "Content-type: text/html\n\n"; #HTTPヘッダ出力
use Image::Magick;
$image = Image::Magick->new;              # 画像オブジェクトの生成
# Pingメソッドで画像(200x150サイズ)の情報を取得する
($p_width, $p_height, $p_size, $p_format) = $image ->Ping('sample1.JPG');
$image ->Read('sample1.JPG');             # 画像（200x150サイズ）を読み込む
($g_width, $g_height, $g_size, $g_format) # Getメソッドで属性値を取得する
     = $image->Get('width', 'height', 'filesize', 'magick');
print "Pingで取得：".$p_width.",".$p_height.",".$p_size.",".$p_format."|";
print "Getで取得 ：".$g_width.",".$g_height.",".$g_size.",".$g_format;
#結果：Pingで取得：200,150,7917,JPEG | Getで取得 ：200,150,7917,JPEG
undef $image;                          # 画像オブジェクトを破棄してメモリを開放

print "</body></html>";
