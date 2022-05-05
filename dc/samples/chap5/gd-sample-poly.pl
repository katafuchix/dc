#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD;
$img = new GD::Image(100,100);
$white = $img->colorAllocate(255,255,255);   #白を設定
$black = $img->colorAllocate(0,0,0);         #黒を設定
$poly = new GD::Polygon;             # 多角形オブジェクトの生成
$poly->addPt(10,10);                 # 頂点座標(10,10)を追加
$poly->addPt(30,10);                 # 頂点座標(30,10)を追加
@x_y = $poly->getPt(1);              # 頂点座標(20,10)を取得
$poly->deletePt(1);                  # 頂点座標(20,10)を削除
$poly->addPt(@x_y);                  # 取得した座標を追加
$poly->addPt(90,95);                 # 頂点座標(90,95)を設定
$poly->setPt(2,10,95);               # 頂点座標(90,95)を(10,95)に変更
$img->polygon($poly,$black);         # 指定した頂点をつないだ三角形を描く
$poly = new GD::Polygon;             # 多角形オブジェクトを作成
$poly->addPt(60,10);                 # 頂点座標(60,10)を設定
$poly->toPt (30,10);                 # 頂点座標(90,20)を追加（相対的に指定）
$poly->addPt(60,95);                 # 頂点座標(60,95)を設定
$img->polygon($poly,$black);         # 指定した頂点をつないだ三角形を描く
binmode STDOUT;                      # バイナリ出力に設定
print $img->png();                   #PNG形式で画像を出力する


