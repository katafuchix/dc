print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # 画像オブジェクトの生成
$image ->Read('sample1.JPG');          # 画像（200x160）を読み込む
# 縦幅20、横幅20の平面的な赤い枠を追加する。サイズは220x180になる
$image ->Border(width=>20, height=>20, fill=>'red');
# 縦幅10、横幅10の立体的な赤い枠を追加する。サイズは220x180になる
# $image ->Frame(width=>20, height=>20, outer => 10 ,inner => 10,fill=>'red');
# 縦幅10、横幅10に明暗を付け画像を浮き上げる
$image ->Raise(width=>10, height=>10,raise => true);
binmode STDOUT;
$image->Write('jpeg:-');               # 画像をJPEGで出力
undef $image;                          # 画像オブジェクトを破棄してメモリを開放
exit;
