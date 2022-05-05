print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;        # 画像オブジェクトの生成
$image ->Read('sample1.JPG');       # 画像（200x160）を読み込む
$image ->OilPaint(radius=>2);       # 画像に油絵効果をつける
binmode STDOUT;
$image->Write('jpeg:-');            # 画像をJPEGで出力
undef $image;                       # 画像オブジェクトを破棄してメモリを開放
exit;
