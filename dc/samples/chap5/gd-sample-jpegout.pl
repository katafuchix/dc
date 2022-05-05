#!/user/local/perl
print "Content-type: image/jpeg\n\n"; #HTTPヘッダ出力

use GD;
$img = newFromPng GD::Image('./gd_sample.PNG'); # gd_sample.PNGを読み込み
binmode STDOUT;                                 # バイナリ出力に設定
print $img->jpeg(10);                           # JPEG形式で低画質の画像を出力する

