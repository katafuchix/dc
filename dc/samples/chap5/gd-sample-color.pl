#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD;
$img = new GD::Image(100,100);
$white = $img->colorAllocate(255,255,255);   #白を設定（背景が白に設定される）
$red   = $img->colorAllocate(255,0,0);       #赤を設定
$yellow= $img->colorAllocate(255,255,0);     #黄色を設定
$green = $img->colorAllocate(0,255,0);       #緑を設定
$cyan  = $img->colorAllocate(0,255,255);     #シアン（水色）を設定
$blue  = $img->colorAllocate(0,0,255);       #青を設定
$mazen = $img->colorAllocate(255,0,255);     #マゼンタ（紫）を設定
$black = $img->colorAllocate(0,0,0);         #黒を設定
$img->line(0,10,100,10,$black);              #黒で線を引く
$img->line(0,20,100,20,$red);                #赤で線を引く
$img->line(0,30,100,30,$yellow);             #黄色で線を引く
$img->line(0,40,100,40,$green);              #緑で線を引く
$img->line(0,50,100,50,$cyan);               #シアンで線を引く
$img->line(0,60,100,60,$blue);               #青で線を引く
$img->line(0,70,100,70,$mazen);              #マゼンタで線を引く
binmode STDOUT;                      # バイナリ出力に設定
print $img->png();                   #PNG形式で画像を出力する

