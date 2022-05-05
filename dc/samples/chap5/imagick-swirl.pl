print "Content-type: image/jpeg\n\n";

use Image::Magick;
$image = Image::Magick->new;           # 画像オブジェクトの生成
$image ->Read('sample1.JPG');          # 画像（200x160サイズ）を読み込む
$image->Swirl( degrees=>180);          # 画像を中心から時計方向に180度ねじる
binmode STDOUT;
$image->Write('jpeg:-');               # 画像をJPEGで出力
undef $image;                          # 画像オブジェクトを破棄してメモリを開放
exit;
