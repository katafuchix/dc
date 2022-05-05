#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD;
$img = new GD::Image(100,100);
$white = $img->colorAllocate(255,255,255);   # 白を設定（背景が白に設定される）
$blue  = $img->colorAllocate(0,0,255);       # 青を設定
$black = $img->colorAllocate(0,0,0);         # 黒を設定
$img->rectangle(5,5,95,95,$black);           # 四角を黒で描く
$img->fill(50,50,$blue);                     # 青で四角を塗りつぶす
binmode STDOUT;                              # バイナリ出力に設定
print $img->png();                           #PNG形式で画像を出力する


