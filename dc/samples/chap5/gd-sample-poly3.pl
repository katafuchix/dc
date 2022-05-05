#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use GD;
$img = new GD::Image(100,100);
$white = $img->colorAllocate(255,255,255);   #白を設定
$black = $img->colorAllocate(0,0,0);         #黒を設定
$poly = new GD::Polygon;             # 多角形オブジェクトを作成
$poly->addPt(10,10);                 # 頂点座標(10,10)を追加
$poly->addPt(30,10);                 # 頂点座標(30,10)を追加
$poly->addPt(10,35);                 # 頂点座標(10,35)を追加
print $poly->length."<br>";          # 頂点数表示：3
@poly_vertices = $poly->vertices;    # 3つの頂点座標のリストを取得
foreach $v ($poly->vertices){        # 頂点座標を取得
   print "(".join(',',@$v).")";      # 結果例：(10,10)(30,10)(10,35)
}
# 三角形を囲む最小の四角形の座標を取得
print "<br>(".join(',',$poly->bounds).")";  # 結果例：(10,10)(30,10)(10,35)

print "</body></html>"; #HTML出力

