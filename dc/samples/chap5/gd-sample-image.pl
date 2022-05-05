#!/user/bin/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD;
$img = new GD::Image(100,100);    # 新しいイメージを作成
$img->trueColor(1);    # 24ビットの色データを使う設定に変更
$img->trueColor(0);    # 8ビットの色データを使う設定に戻す
$white = $img->colorAllocate(255,255,255); # 白色を設定
$red   = $img->colorAllocate(255,0,0); # 赤色を設定
$black = $img->colorAllocate(0,0,0); # 黒色を設定
$img->rectangle(0,0,99,99,$black); # 黒の正方形を描く
$img->arc(50,50,50,50,0,360,$red); # 赤い円を描画
$img->fill(50,50,$red); # 楕円を赤で塗る
binmode STDOUT; # バイナリ・ストリームへ書きこむことを確実にする
print $img->png;# 画像をPNG形式で出力する

