print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # 画像オブジェクトの生成
$image ->Read('sample1.JPG');          # 画像を読み込む
$image ->Roll(x=>100,y=>50);           # x方向に100、y方向に50ずらす
#$image -> Roll(geometry=>'+100+50');  # geometryを使ってずらす場合
binmode STDOUT;
$image->Write('jpeg:-');               # 画像をJPEGで出力
undef $image;                          # 画像オブジェクトを破棄してメモリを開放
exit;
