print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image1 = Image::Magick->new;        # 画像オブジェクトの生成
$image1 ->Read('sample1.JPG');       # 元画像（200x160）を読み込む
$image2 = Image::Magick->new;        # 合成する画像を読み込む
$image2 ->Read('sample2.JPG');
$image1->Resize(width=>100, height=>100); # 元画像のサイズ変更
# 画像をIn方式で合成する
$image1->Composite(image=>$image2, compose=>'In', gravity=>'Center');
binmode STDOUT;
$image1->Write('jpeg:-');            # 画像をJPEGで出力
undef $image1;                       # 画像オブジェクトを破棄してメモリを開放
undef $image2;
exit;
