print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;        # 画像オブジェクトの生成
$image ->Read('sample1.JPG');       # 画像（200x160）を読み込む
#画像を時計回りに45度回転させ、背景を水色に設定する
$image ->Rotate(degrees => 45 , color => 'cyan');
binmode STDOUT;
$image->Write('jpeg:-');            # 画像をJPEGで出力
undef $image;                       # 画像オブジェクトを破棄してメモリを開放
exit;
