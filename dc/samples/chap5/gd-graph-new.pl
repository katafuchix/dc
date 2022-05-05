#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD::Graph::bars; # 棒グラフモジュールの読込み
@data = ( [1..9], # x軸データ
[2, 1, 3, 0, 5, 6, 1, 2, 2] ); # y軸データ
$graph = new GD::Graph::bars(); # 棒グラフオブジェクトを生成
binmode STDOUT; # バイナリ出力に設定
print $graph->plot(\@data)->png; # PNG形式でグラフを描画

