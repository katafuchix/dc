#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD::Graph::area;                 # 領域グラフモジュールの読込み

@data = (                            # グラフのデータを設定
  ["1st","2nd","3rd","4th","5th"],   # x方向の値の設定
  [2,4,6,8,10],                      # y方向の値の設定(背面)
  [1,3,5,7,9]                        # y方向の値の設定(前面)
);

$graph = new GD::Graph::area();      # 棒グラフオブジェクトを作成
binmode STDOUT;                      # バイナリ出力に設定
print $graph->plot(\@data)-> png;    # PNG形式でグラフを描画


