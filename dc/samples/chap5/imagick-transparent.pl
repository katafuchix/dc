print "Content-type: image/gif\n\n";

use Image::Magick;
$image = Image::Magick->new;           # 画像オブジェクトの生成
$image ->Read('sample1.PNG');          # gif画像（200x160サイズ）を読み込む
$image->Draw(primitive=>'circle', points=>"100,75 180,75", #赤い円を描く
                                  strokewidth => 20 , stroke=>'red');
$image->Transparent(color=>"red");     # 赤を透過する
binmode STDOUT;
$image->Write('gif:-');
undef $image;                          # 画像オブジェクトを破棄してメモリを開放
exit;
