#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD;
$img = new GD::Image(100,100);
$white = $img->colorAllocate(255,255,255);   #白を設定
$black = $img->colorAllocate(0,0,0);         #黒を設定
$poly = new GD::Polygon;                     # 多角形オブジェクトを作成
$poly->addPt(50,0);                          # 頂点座標(50,0)を設定
$poly->addPt(99,95);                         # 頂点座標(99,95)を設定
$poly->addPt(0,95);                          # 頂点座標(0,95)を設定
$img->polygon($poly,$black);                 # 指定した頂点を繋いだ三角形を描く
binmode STDOUT;                              # バイナリ出力に設定
print $img->png();                           #PNG形式で画像を出力する


