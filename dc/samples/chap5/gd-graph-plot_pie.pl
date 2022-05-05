#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD::Graph::pie;                  # 円グラフモジュールの読込み

@data = (                            # グラフのデータを設定
  ["1st","2nd","3rd","4th","5th"],   # 円グラフの項目の設定
  [1,3,5,7,9],                       # 円グラフの値の設定(
  [2,4,6,8,10]                       # ここで設定した値は無視される
);

$graph = new GD::Graph::pie();      # 棒グラフオブジェクトを作成
binmode STDOUT;                      # バイナリ出力に設定
print $graph->plot(\@data)-> png;    # PNG形式でグラフを描画


