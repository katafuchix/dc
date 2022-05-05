#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD;
$myImage = new GD::Image(100,100); #出力先画像オブジェクトを設定
$white = $myImage->colorAllocate(255,255,255); #白を設定
$black = $myImage->colorAllocate(0,0,0); #黒を設定
$srcImage = new GD::Image(50,50); #コピー元画像オブジェクトを設定
$white = $srcImage->colorAllocate(255,255,255); #白を設定
$black = $srcImage->colorAllocate(0,0,0); #黒を設定
$srcImage->rectangle(0,0,20,10,$black); #矩形を描画
# $srcImageの座標(0,0)から25x25ピクセルの領域を
# $myImageの座標(50,50)へ拡大コピーする
$myImage->copyResized($srcImage,50,50,0,0,50,50,25,25);
# $srcImageの座標(0,0)から25x25 ピクセルの領域を
# $myImageの座標(10,10)にコピーする（上書き）
$myImage->copy($srcImage,10,10,0,0,25,25);
# $myImageを90度回転した画像オブジェクトを取得
$myImage90 = $myImage->copyRotate90();
binmode STDOUT; # バイナリ出力に設定
print $myImage90->png(); #PNG形式で画像を出力する

