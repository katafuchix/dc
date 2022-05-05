print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # 画像オブジェクトの生成
$image ->Read('sample1.JPG');          # 画像（200x150サイズ）を読み込む
# width,heightを指定して画像を400x300にリサイズしてBoxフィルターでぼかす
$image ->Resize(width => 400 , height => 300 , blur =>3);
# geometryを指定して400x300にリサイズする
#$image ->Resize(geometry => (400,300) , blur => 3 );
binmode STDOUT;
$image->Write('jpeg:-');               # 画像をJPEGで出力
undef $image;                          # 画像オブジェクトを破棄してメモリを開放
exit;
