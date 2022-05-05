print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # 画像オブジェクトの生成
$image ->Read('sample1.JPG');          # 画像（200x160サイズ）を読み込む
# 輝度：200 彩度：50 色相：30に指定
$image->Modulate( brightness=>200, saturation=>50, hue=>30 );
binmode STDOUT;
$image->Write('jpeg:-');               # 画像をJPEGで出力
undef $image;                          # 画像オブジェクトを破棄してメモリを開放
exit;
