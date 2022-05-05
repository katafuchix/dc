#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD::Graph::mixed;                # 混合グラフモジュールの読込み
@data = (                            # グラフのデータを設定
  ["1st","2nd","3rd","4th","5th"],   # x方向の値の設定
  [1,3,5,7,9],                       # y方向の値の設定(1本目)
  [2,4,6,8,10]                       # y方向の値の設定(2本目)
);

$graph = new GD::Graph::mixed();     # 混合グラフオブジェクトを作成
# 混合グラフの1本目を縦棒グラフに、2本目を折れ線グラフに設定
$graph->set(
  types => [ 'bars', 'lines'],
);

binmode STDOUT;                      # バイナリ出力に設定
print $graph->plot(\@data)-> png;    # PNG形式でグラフを描画

