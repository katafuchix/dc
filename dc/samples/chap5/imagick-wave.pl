print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;        # 画像オブジェクトの生成
$image ->Read('sample1.JPG');       # 画像（200x160）を読み込む
#縦幅が8、横幅が5の波でウェーブ効果をつける
$image ->Wave(amplitude => 8 , wavelength => 5);
#$image ->Wave(geometry => '8x5');  # geometry属性を使ってウェーブ効果をつける
binmode STDOUT;
$image->Write('jpeg:-');            # 画像をJPEGで出力
undef $image;                       # 画像オブジェクトを破棄してメモリを開放
exit;
