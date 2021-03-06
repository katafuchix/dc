#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD::Graph::linespoints;           # 折れ線・点グラフモジュールの読込み

@data = (                             # グラフのデータを設定
  ["1st","2nd","3rd","4th","5th"],    # x方向の値の設定
  [1,3,5,7,9],                        # y方向の値の設定(1本目)
  [2,4,6,8,10]                        # y方向の値の設定(2本目)
);

$graph = new GD::Graph::linespoints();# 折れ線・点グラフオブジェクトを作成
binmode STDOUT;                       # バイナリ出力に設定
print $graph->plot(\@data)-> png;     # PNG形式でグラフを描画

