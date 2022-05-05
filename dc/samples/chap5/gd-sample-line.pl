#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD;
$img = new GD::Image(100,100);                      # 新しい画像オブジェクトを作成
$white = $img->colorAllocate(255,255,255);   #白を設定
$black = $img->colorAllocate(0,0,0);         #黒を設定
$img->setPixel(50,50,$black);                # 点を描く
$img->line(5,10,95,10,$black);               # 線を描く
$img->dashedLine(5,25,95,25,$black);         # 点線を描く
$img->line(5,75,95,75,$black);               # 線を描く
$img->dashedLine(5,95,95,95,$black);         # 点線を描く
binmode STDOUT;                              # バイナリ出力に設定
print $img->png();                           #PNG形式で画像を出力する

