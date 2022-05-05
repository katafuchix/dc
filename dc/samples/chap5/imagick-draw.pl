print "Content-type: image/jpeg\n\n";
use Image::Magick;
$image = Image::Magick->new;           # 画像オブジェクトの生成
$image->Set(size=>"200x160");          # 200x160のキャンバスを作成
$image->ReadImage("xc:white");         # 背景が白の画像を設定
#(0,5)に青の点を描く
$image->Draw(primitive=>'point', points=>'100,5', fill=>'blue');
#(0,10)から（200,10）に青の線を描く
$image->Draw(primitive=>'line', points=>'0,10 200,10', stroke=>'blue');
#(10,20)から(190,30)に青の輪郭で赤く塗りつぶした四角形を描く
$image->Draw(primitive=>'rectangle', points=>"10,20 190,30",
             stroke=>'blue', fill=>'red');
#中心点を(100,50)として、縦幅に20ピクセル、横幅180ピクセルの楕円を描く
$image->Draw(primitive=>'ellipse', points=>"100,50 90,10 0,360"
           , stroke=>'brown',fill => "pink");
#中心点を(100,80)として、(100,90)を通る青い円を描く（半径10ピクセル）
$image->Draw(primitive=>'circle', points=>"100,80 100,90", stroke=>'blue');
#(0,100) (50,120) (100,100) (150,120) (200,100)を通る折れ線を描く
$image->Draw(primitive=>'polyline',
             points=>"0,100 50,120 100,100 150,120 200,100");
#(10,130) (10,150) (190,130) (190,150)を順に通る多角形を描く
$image->Draw(primitive=>'polygon', points=>"10,130 10,150 190,130 190,150 ");
#境界線まで(50,80)を基点として黄色でキャンバスを塗りつぶす
$image->Draw(primitive=>'color', points=>'50,80',
             method=>'Floodfill',fill=>'yellow');
binmode STDOUT;
$image->Write('jpeg:-');               # 画像をJPEGで出力
undef $image;                          # 画像オブジェクトを破棄してメモリを開放
exit;
