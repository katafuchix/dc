print "Content-type: image/jpeg\n\n";

use Image::Magick;
$image = Image::Magick->new;           # 画像オブジェクトの生成
$image ->Read('sample1.JPG');          # 画像（200x160サイズ）を読み込む
$image ->Threshold(threshold => '30%' );      # 輝度30%で閾値処理
#$image ->BlackThreshold(threshold => '30%'); # 輝度30%以下を黒く塗りつぶす
#$image ->WhiteThreshold(threshold => '30%'); # 輝度30%以下を白く塗りつぶす
binmode STDOUT;
$image->Write('jpeg:-');               # 画像をJPEGで出力
undef $image;                          # 画像オブジェクトを破棄してメモリを開放

exit;
