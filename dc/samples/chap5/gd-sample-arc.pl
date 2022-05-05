#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力
use GD;
$img = new GD::Image(100,100);               # 新しい画像オブジェクトを作成
$white = $img->colorAllocate(255,255,255);   # 白を設定
$black = $img->colorAllocate(0,0,0);         # 黒を設定
$img->rectangle(5,10,15,20,$black);          # 小さい四角を描く
$img->rectangle(0,0,99,99,$black);           # 大きい四角を描く
$img->filledRectangle(85,10,95,20,$black);   # 黒で塗りつぶした小さい四角を描く
$img->arc(50,30,30,30,0,360,$black);         # 円を描く
$img->arc(50,55,70,30,0,180,$black);         # 下半楕円を描く
$img->arc(50,90,20,40,180,360,$black);       # 上半楕円を描く
binmode STDOUT;                              # バイナリ出力に設定
print $img->png();                           #PNG形式で画像を出力する

