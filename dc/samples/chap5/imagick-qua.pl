print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # 画像オブジェクトの生成
$image ->Read('sample1.JPG');          # 画像を読み込む
   # 白黒画像に減色する（ディザ法を適用）
$image ->Quantize(colorspace=>gray,dither=>1);
binmode STDOUT;
$image->Write('jpeg:-');               # 画像をJPEGで出力
undef $image;                          # 画像オブジェクトを破棄してメモリを開放
exit;
