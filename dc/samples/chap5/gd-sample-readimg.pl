#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD;
$img = newFromPng GD::Image('./gd_sample.PNG'); # gd_sample.PNGを読み込み
binmode STDOUT;                                 # バイナリ出力に設定
print $img->png();                              # PNG形式で画像を出力する


