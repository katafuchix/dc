print "Content-type: image/jpeg\n\n";

use Image::Magick;
$image = Image::Magick->new;           # 画像オブジェクトの作成
$image->Set(size=>"200x200");          # 200x200のキャンバスを作成
$image ->ReadImage('xc:white');        # 背景色が白の空画像を読み込む
#円を描く
$image->Draw(primitive=>'circle', points=>"100,100 150,150", stroke=>'blue');
binmode STDOUT;
$image->Write('jpeg:-');               # 画像をJPEGで出力
undef $image;                          # 画像オブジェクトを破棄してメモリを解放
exit;
