print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;        # 画像オブジェクトの生成
$image ->Read('sample1.JPG');       # 画像（200x160）を読み込む
# (100,50)から縦幅100、横幅100の領域を切り出す
$image->Chop(width=>30,height=>30, x=>100, y=>50);
#$image->Chop(geometry=>'30x30',x=>100, y=>50 );
binmode STDOUT;
$image->Write('jpeg:-');            # 画像をJPEGで出力
undef $image;                       # 画像オブジェクトを破棄してメモリを開放
exit;
