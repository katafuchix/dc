print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image1 = Image::Magick->new;        # 画像オブジェクトの生成
$image1 ->Read('sample1.JPG');       # 元画像（200x160）を読み込む
$image2 = Image::Magick->new;        # 合成する画像を読み込む
$image2 ->Read('sample2.JPG');
$image2->Resize(width=>40, height=>40); # 合成する画像のサイズ変更
# 画像をOver方式で合成する
$image1->Composite(image=>$image2, compose=>'Over', gravity=>'Center');
binmode STDOUT;
$image1->Write('jpeg:-');            # 画像をJPEGで出力
undef $image1;                       # 画像オブジェクトを破棄してメモリを開放
undef $image2;
exit;
