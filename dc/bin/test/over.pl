#print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image1 = Image::Magick->new;        # 画像オブジェクトの生成
#$image1 ->Read('sample1.JPG');       # 元画像（200x160）を読み込む
$image1 ->Read('kamon.gif');
$image2 = Image::Magick->new;        # 合成する画像を読み込む
#$image2 ->Read('sample2.JPG');
$image2 ->Read('moji1.gif');
#$image2->Resize(width=>100, height=>100); # 合成する画像のサイズ変更
# 画像をOver方式で合成する
$image1->Composite(image=>$image2, compose=>'Over', gravity=>'Center');
binmode STDOUT;
#$image1->Write('jpeg:-');            # 画像をJPEGで出力
$image1->Write('textanime1.gif');



$image3 = Image::Magick->new;        # 画像オブジェクトの生成
#$image1 ->Read('sample1.JPG');       # 元画像（200x160）を読み込む
$image3 ->Read('kamon.gif');
$image4 = Image::Magick->new;        # 合成する画像を読み込む
#$image2 ->Read('sample2.JPG');
$image4 ->Read('moji2.gif');
#$image4->Resize(width=>100, height=>100); # 合成する画像のサイズ変更
# 画像をOver方式で合成する
$image3->Composite(image=>$image4, compose=>'Over', gravity=>'Center');
binmode STDOUT;
#$image1->Write('jpeg:-');            # 画像をJPEGで出力
$image3->Write('textanime2.gif');


# オブジェクト作成
my $image = Image::Magick->new;
# 画像読み込み
$image->Read(qw(textanime1.gif textanime2.gif));
#$image->Read(qw($image1->Write('jpeg:-') $image3->Write('jpeg:-')));


#$image->Set(loop=>0);
$image->Set(loop=>0);
$image->Set(dispose=>2);

$image->Set(delay=>50);


binmode STDOUT;
$image->Write('kamonanime.gif');



undef $image1;                       # 画像オブジェクトを破棄してメモリを開放
undef $image2;
exit;
