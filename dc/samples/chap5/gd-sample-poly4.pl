#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD;
$img = new GD::Image(200,200);
$white = $img->colorAllocate(255,255,255);   #白を設定
$black = $img->colorAllocate(0,0,0);         #黒を設定
$poly = new GD::Polygon;             # 多角形オブジェクトを作成
$poly->addPt(10,10);                 # 頂点座標(10,10)を追加
$poly->addPt(30,10);                 # 頂点座標(30,10)を追加
$poly->addPt(10,35);                 # 頂点座標(10,35)を追加
@poly_bounds = $poly->bounds;        # 三角形が入る最小の四角形の頂点を取得
                                     # この場合は左上(10,10)右下(30,35)の四角形
$img->filledPolygon($poly,$black);   # 三角形を描く
$img->rectangle(@poly_bounds,$black);# boundで取得した四角形を描く
# 左上(10,10)右下(30,35)の四角形に収まっている三角形を
# 左上(5,0)右下(50,50)の四角形に収まるよう変形する
$poly->map(@poly_bounds,5,0,50,50); 
$img->polygon($poly,$black);         # 変形後の三角形を描く
$poly->offset(30,30);                # 三角形をx方向に30、y方向に30移動する
# 頂点は(10,10)→(40,40) (30,10)→(60,40) (10,35)→(40,65)となる
$img->polygon($poly,$black);         # 移動後の三角形を描く
$poly->scale(2,2);                   # 頂点座標を2倍にして三角形を変形する
# (40,40)→(80,80) (60,40)→(120,80) (40,65)→(80,130)
$img->filledPolygon($poly,$black);   # 拡大後の三角形を描く
binmode STDOUT;                      # バイナリ出力に設定
print $img->png();                   #PNG形式で画像を出力する


