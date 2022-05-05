print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;        # 画像オブジェクトの生成
$image ->Read('sample1.JPG');       # 画像（200x160）を読み込む
# (30,30)から縦幅100、横幅100の領域を切り出す
$image->Crop(width=>100,height=>100, x=>30, y=>30 );
#$image->Crop(geometry=>'100x100',x=>30, y=>30 );
binmode STDOUT;
$image->Write('jpeg:-');            # 画像をJPEGで出力
undef $image;                       # 画像オブジェクトを破棄してメモリを開放
exit;
