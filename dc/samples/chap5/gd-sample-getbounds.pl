#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use GD;
$img = newFromPng GD::Image('./gd_sample.PNG'); #gd_sample.PNGを読み込み
@img_size = $img->getBounds();                  #gd_sample.PNGのサイズを取得
print @img_size[0]."x".@img_size[1];            #gd_sample.PNGのサイズを表示
                                                #結果例："131x108"
print "</body></html>"; #HTML出力

