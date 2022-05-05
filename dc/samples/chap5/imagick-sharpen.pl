print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # 画像オブジェクトの生成
$image ->Read('sample1.JPG');          # 画像（200x160サイズ）を読み込む
# 度合い5.0 標準偏差0.5のシャープ効果をつける
$image ->Sharpen( radius=>5.0, sigma=>0.5 );
# 度合い5.0 標準偏差0.5をgeometryで指定
#$image ->Sharpen( geometry=>'5.0x0.5' );
binmode STDOUT;
$image->Write('jpeg:-');               # 画像をJPEGで出力
undef $image;                          # 画像オブジェクトを破棄してメモリを開放
exit;
